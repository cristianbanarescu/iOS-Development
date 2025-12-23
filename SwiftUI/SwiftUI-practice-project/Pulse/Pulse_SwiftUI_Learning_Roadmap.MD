# Pulse — SwiftUI End-to-End Learning Roadmap
**Enhanced Edition with Code Samples & Offline Tasks**

Generated using Claude.
For demo/practice mode only.

---

## Step 1: Project & App Structure

### Key Topics
- SwiftUI App lifecycle
- App protocol and WindowGroup
- Folder and module organization
- Preview system

### Reviewer Questions
- Why does SwiftUI not need AppDelegate by default?
- What responsibilities belong in PulseApp?

### Code Sample: PulseApp.swift
```swift
import SwiftUI

@main
struct PulseApp: App {
    var body: some Scene {
        WindowGroup {
            FeedView()
        }
    }
}
```

### TODOs
- [ ] Create PulseApp.swift using @main and App
- [ ] Set FeedView as the root view inside WindowGroup
- [ ] Create folder structure: Views/, Models/, ViewModels/, Services/
- [ ] Add at least one SwiftUI Preview to FeedView

---

## Step 2: Core View Building

### Key Topics
- View protocol
- Stacks and layout primitives
- Modifiers and order
- Reusable views

### Reviewer Questions
- What is the single responsibility of this view?
- Why does modifier order matter here?

### Code Sample: ActivityRowView
```swift
import SwiftUI

struct ActivityRowView: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(activity.title)
                    .font(.headline)
                Text(activity.body)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding()
    }
}
```

### TODOs
- [ ] Implement ActivityRowView with VStack/HStack
- [ ] Use Text and Spacer to layout content
- [ ] Apply padding and font modifiers intentionally
- [ ] Ensure ActivityRowView has no state

---

## Step 3: State Management Fundamentals

### Key Topics
- @State usage
- View invalidation
- Why views are structs

### Reviewer Questions
- Who owns this state?
- What triggers a re-render?

### Code Sample: FeedView with @State
```swift
struct FeedView: View {
    @State private var activities: [Activity] = []
    
    var body: some View {
        List(activities) { activity in
            ActivityRowView(activity: activity)
        }
        .onAppear {
            loadActivities()
        }
    }
    
    func loadActivities() {
        // Simulate loading
        activities = [
            Activity(id: 1, title: "First Activity", body: "Description here"),
            Activity(id: 2, title: "Second Activity", body: "Another description")
        ]
    }
}
```

### TODOs
- [ ] Add @State activities array to FeedView
- [ ] Simulate loading activities locally
- [ ] Trigger state changes via Button or onAppear
- [ ] Verify UI refreshes correctly

---

## Step 4: Data Flow Between Views

### Key Topics
- @Binding basics
- Data down, actions up
- Closures for events

### Reviewer Questions
- Why is a closure better than a binding here?
- Who owns the data being mutated?

### Code Sample: ActivityRowView with Closure
```swift
struct ActivityRowView: View {
    let activity: Activity
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack {
                VStack(alignment: .leading) {
                    Text(activity.title)
                        .font(.headline)
                    Text(activity.body)
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()
        }
    }
}

// Usage in FeedView
ActivityRowView(activity: activity) {
    print("Tapped: \(activity.title)")
}
```

### TODOs
- [ ] Pass Activity into ActivityRowView as immutable data
- [ ] Add a tap or button in ActivityRowView
- [ ] Pass a closure from FeedView to handle row actions
- [ ] Avoid using @Binding for navigation or selection

---

## Step 5: Lists & Dynamic Views

### Key Topics
- List and ForEach
- Identifiable models
- Dynamic row updates
- Swipe actions

### Reviewer Questions
- Why must list items be identifiable?
- What happens when identity changes?

### Code Sample: Activity Model (Identifiable)
```swift
struct Activity: Identifiable, Codable {
    let id: Int
    let title: String
    let body: String
}
```

### Code Sample: FeedView with List
```swift
struct FeedView: View {
    @State private var activities: [Activity] = []
    
    var body: some View {
        List {
            ForEach(activities) { activity in
                ActivityRowView(activity: activity) {
                    print("Tapped: \(activity.title)")
                }
            }
            .onDelete(perform: deleteActivity)
        }
    }
    
    func deleteActivity(at offsets: IndexSet) {
        activities.remove(atOffsets: offsets)
    }
}
```

### TODOs
- [ ] Conform Activity to Identifiable
- [ ] Render activities using List and ForEach
- [ ] Support swipe-to-delete using .onDelete
- [ ] Update state and verify row animations work

---

## Step 6: Navigation

### Key Topics
- NavigationStack
- NavigationLink
- Passing data through navigation

### Reviewer Questions
- Where should navigation state live?
- What should not be passed through navigation?

### Code Sample: Navigation Setup
```swift
struct FeedView: View {
    @State private var activities: [Activity] = []
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities) { activity in
                    NavigationLink(value: activity) {
                        ActivityRowView(activity: activity)
                    }
                }
            }
            .navigationTitle("Pulse")
            .navigationDestination(for: Activity.self) { activity in
                ActivityDetailView(activity: activity)
            }
        }
    }
}
```

### Code Sample: ActivityDetailView
```swift
struct ActivityDetailView: View {
    let activity: Activity
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(activity.title)
                    .font(.title)
                Text(activity.body)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Details")
    }
}
```

### TODOs
- [ ] Wrap FeedView in NavigationStack
- [ ] Navigate from row to ActivityDetailView using NavigationLink
- [ ] Pass selected Activity to detail screen
- [ ] Avoid embedding navigation logic inside rows

---

## Step 7: User Input

### Key Topics
- TextField and forms
- Focus management
- Validation

### Reviewer Questions
- Who owns form state?
- When should validation run?

### Code Sample: EditActivityView
```swift
struct EditActivityView: View {
    @State private var title: String = ""
    @State private var body: String = ""
    @FocusState private var focusedField: Field?
    
    enum Field {
        case title, body
    }
    
    var body: some View {
        Form {
            Section("Activity Details") {
                TextField("Title", text: $title)
                    .focused($focusedField, equals: .title)
                
                TextField("Description", text: $body, axis: .vertical)
                    .focused($focusedField, equals: .body)
                    .lineLimit(5...10)
            }
            
            Section {
                Button("Save") {
                    save()
                }
                .disabled(!isValid)
                
                Button("Cancel", role: .cancel) {
                    cancel()
                }
            }
        }
        .navigationTitle("Edit Activity")
    }
    
    var isValid: Bool {
        !title.isEmpty && !body.isEmpty
    }
    
    func save() {
        // Save logic
    }
    
    func cancel() {
        // Cancel logic
    }
}
```

### TODOs
- [ ] Create EditActivityView with a Form
- [ ] Bind TextField values to local @State
- [ ] Add basic validation before saving
- [ ] Implement Cancel / Save actions

---

## Step 8: View Composition & Architecture

### Key Topics
- MVVM responsibilities
- Avoiding fat views
- Separation of concerns

### Reviewer Questions
- Why should views not contain business logic?
- What makes a ViewModel testable?

### Code Sample: FeedViewModel (Basic)
```swift
import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func loadActivities() {
        isLoading = true
        // Business logic here
        // Simulate data loading
        activities = [
            Activity(id: 1, title: "Sample", body: "Description")
        ]
        isLoading = false
    }
    
    func deleteActivity(at offsets: IndexSet) {
        activities.remove(atOffsets: offsets)
    }
}
```

### Code Sample: FeedView with ViewModel
```swift
struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.activities) { activity in
                    ActivityRowView(activity: activity)
                }
                .onDelete(perform: viewModel.deleteActivity)
            }
            .navigationTitle("Pulse")
            .onAppear {
                viewModel.loadActivities()
            }
        }
    }
}
```

### TODOs
- [ ] Create FeedViewModel
- [ ] Move business logic out of FeedView
- [ ] Expose state via @Published properties
- [ ] Inject ViewModel into FeedView

---

## Step 9: Observable State & Data Models

### Key Topics
- ObservableObject
- @Published
- StateObject lifecycle

### Reviewer Questions
- Who owns the ObservableObject?
- What happens if it is recreated?

### Code Sample: Complete ViewModel
```swift
@MainActor
class FeedViewModel: ObservableObject {
    @Published var activities: [Activity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let service: ActivityService
    
    init(service: ActivityService = JSONPlaceholderService()) {
        self.service = service
    }
    
    func loadActivities() async {
        isLoading = true
        errorMessage = nil
        
        do {
            activities = try await service.fetchActivities()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
```

### TODOs
- [ ] Mark FeedViewModel as ObservableObject
- [ ] Use @StateObject in FeedView
- [ ] Use @ObservedObject in child views if needed
- [ ] Avoid unnecessary @Published properties

---

## Step 10: Async & Concurrency

### Key Topics
- async/await
- Tasks and cancellation
- Main actor isolation

### Reviewer Questions
- When is a task cancelled?
- Why prefer .task over onAppear?

### Code Sample: Async Loading
```swift
struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.activities) { activity in
                ActivityRowView(activity: activity)
            }
            .navigationTitle("Pulse")
            .task {
                await viewModel.loadActivities()
            }
        }
    }
}
```

### TODOs
- [ ] Fetch activities using async function
- [ ] Call async load from .task modifier
- [ ] Handle cancellation correctly
- [ ] Update UI on the main actor

---

## Step 11: Networking & API Fetching

### Key Topics
- URLSession
- Codable
- Dependency injection

### Reviewer Questions
- Why abstract networking behind protocols?
- How do you test failures?

### Code Sample: ActivityService Protocol
```swift
protocol ActivityService {
    func fetchActivities() async throws -> [Activity]
    func createActivity(_ activity: Activity) async throws -> Activity
}
```

### Code Sample: JSONPlaceholder Implementation
```swift
class JSONPlaceholderService: ActivityService {
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    func fetchActivities() async throws -> [Activity] {
        let url = URL(string: "\(baseURL)/posts")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let posts = try decoder.decode([Post].self, from: data)
        
        // Map Post to Activity
        return posts.map { post in
            Activity(id: post.id, title: post.title, body: post.body)
        }
    }
    
    func createActivity(_ activity: Activity) async throws -> Activity {
        // POST implementation
        return activity
    }
}

// JSONPlaceholder model
struct Post: Codable {
    let id: Int
    let title: String
    let body: String
}
```

### TODOs
- [ ] Define ActivityService protocol
- [ ] Implement JSONPlaceholderService
- [ ] Decode GET /posts response
- [ ] Inject service into ViewModel

---

## Step 12: View Lifecycle Awareness

### Key Topics
- task(id:)
- Pull-to-refresh
- Preventing duplicate loads

### Reviewer Questions
- Why can onAppear be unreliable?
- How do you prevent duplicate concurrent loads?

### Code Sample: Pull-to-Refresh
```swift
struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.activities) { activity in
                ActivityRowView(activity: activity)
            }
            .navigationTitle("Pulse")
            .refreshable {
                await viewModel.loadActivities()
            }
            .task {
                await viewModel.loadActivities()
            }
        }
    }
}
```

### TODOs
- [ ] Add .refreshable to FeedView
- [ ] Reload data on pull-to-refresh
- [ ] Prevent duplicate concurrent loads

---

## Step 13: Animations

### Key Topics
- Implicit animations
- Explicit animations with withAnimation
- Transitions

### Reviewer Questions
- What exactly is being animated?
- Why might animation not run?

### Code Sample: Animated Deletions
```swift
func deleteActivity(at offsets: IndexSet) {
    withAnimation {
        activities.remove(atOffsets: offsets)
    }
}
```

### Code Sample: Empty State Transition
```swift
if activities.isEmpty {
    ContentUnavailableView(
        "No Activities",
        systemImage: "tray",
        description: Text("Pull to refresh")
    )
    .transition(.opacity)
}
```

### TODOs
- [ ] Animate list insertions and deletions
- [ ] Use withAnimation for state changes
- [ ] Add a simple transition for empty state

---

## Step 14: Conditional UI & State-driven Design

### Key Topics
- Loading, empty, error states
- ContentUnavailableView
- State-driven branching

### Reviewer Questions
- Which state drives this branch?
- How do you avoid flicker?

### Code Sample: State-Driven UI
```swift
struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(error)
                    )
                } else if viewModel.activities.isEmpty {
                    ContentUnavailableView(
                        "No Activities",
                        systemImage: "tray"
                    )
                } else {
                    List(viewModel.activities) { activity in
                        ActivityRowView(activity: activity)
                    }
                }
            }
            .navigationTitle("Pulse")
            .task {
                await viewModel.loadActivities()
            }
        }
    }
}
```

### TODOs
- [ ] Introduce loading and error states in ViewModel
- [ ] Render different UI based on state
- [ ] Add a reusable LoadingView

---

## Step 15: Environment & App-wide State

### Key Topics
- EnvironmentObject
- Global app state
- When to use environment

### Reviewer Questions
- When is global state justified?
- What risks does it introduce?

### Code Sample: AppSettings
```swift
class AppSettings: ObservableObject {
    @Published var isDarkMode: Bool = false
    @Published var sortOrder: SortOrder = .recent
    
    enum SortOrder {
        case recent, alphabetical
    }
}
```

### Code Sample: Injecting Environment
```swift
@main
struct PulseApp: App {
    @StateObject private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            FeedView()
                .environmentObject(settings)
        }
    }
}
```

### Code Sample: Reading Environment
```swift
struct FeedView: View {
    @EnvironmentObject var settings: AppSettings
    
    var body: some View {
        // Use settings.isDarkMode, etc.
    }
}
```

### TODOs
- [ ] Create AppSettings model
- [ ] Inject AppSettings via environment
- [ ] Read environment values in views

---

## Step 16: Persistence

### Key Topics
- UserDefaults
- Simple caching
- Where persistence logic belongs

### Reviewer Questions
- What should never be persisted here?
- When should persistence occur?

### Code Sample: UserDefaults Wrapper
```swift
extension UserDefaults {
    var isDarkMode: Bool {
        get { bool(forKey: "isDarkMode") }
        set { set(newValue, forKey: "isDarkMode") }
    }
}
```

### Code Sample: AppSettings with Persistence
```swift
class AppSettings: ObservableObject {
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.isDarkMode = isDarkMode
        }
    }
    
    init() {
        self.isDarkMode = UserDefaults.standard.isDarkMode
    }
}
```

### TODOs
- [ ] Persist a simple user preference
- [ ] Restore preference on app launch
- [ ] Keep persistence logic out of views

---

## Step 17: Debugging & Best Practices

### Key Topics
- Debugging SwiftUI
- Performance considerations
- Common pitfalls

### Reviewer Questions
- How do you debug over-rendering?
- What are common SwiftUI pitfalls?

### Code Sample: Debug Logging
```swift
func loadActivities() async {
    print("📥 Loading activities...")
    isLoading = true
    
    do {
        activities = try await service.fetchActivities()
        print("✅ Loaded \(activities.count) activities")
    } catch {
        print("❌ Error: \(error)")
        errorMessage = error.localizedDescription
    }
    
    isLoading = false
}
```

### TODOs
- [ ] Add debug logging to ViewModel
- [ ] Use previews to test states
- [ ] Identify and remove unnecessary state

---

## Step 18: Polishing & Production Readiness

### Key Topics
- Reusable styles
- Custom modifiers
- Architecture cleanup

### Reviewer Questions
- What would you refactor before release?
- What technical debt remains?

### Code Sample: Custom Modifier
```swift
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(radius: 2)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}
```

### TODOs
- [ ] Extract reusable modifiers
- [ ] Standardize spacing and fonts
- [ ] Clean up unused code paths

---

## Step 19: Unit Testing

### Key Topics
- ViewModel testing
- Async tests
- Mocking services

### Reviewer Questions
- What should not be unit tested?
- How do you test async failures?

### Code Sample: Mock Service
```swift
class MockActivityService: ActivityService {
    var shouldFail = false
    var mockActivities: [Activity] = []
    
    func fetchActivities() async throws -> [Activity] {
        if shouldFail {
            throw NSError(domain: "Test", code: -1)
        }
        return mockActivities
    }
    
    func createActivity(_ activity: Activity) async throws -> Activity {
        return activity
    }
}
```

### Code Sample: ViewModel Test
```swift
import Testing
@testable import Pulse

@Test func testLoadActivitiesSuccess() async {
    let mockService = MockActivityService()
    mockService.mockActivities = [
        Activity(id: 1, title: "Test", body: "Body")
    ]
    
    let viewModel = FeedViewModel(service: mockService)
    await viewModel.loadActivities()
    
    #expect(viewModel.activities.count == 1)
    #expect(viewModel.errorMessage == nil)
}
```

### TODOs
- [ ] Write unit tests for FeedViewModel
- [ ] Mock ActivityService
- [ ] Test success and failure cases

---

## Step 20: UI Testing

### Key Topics
- XCUITest
- Navigation testing
- Accessibility identifiers

### Reviewer Questions
- What makes UI tests flaky?
- Which flows are worth testing?

### Code Sample: Accessibility Identifiers
```swift
struct FeedView: View {
    var body: some View {
        NavigationStack {
            List(viewModel.activities) { activity in
                ActivityRowView(activity: activity)
                    .accessibilityIdentifier("activity-row-\(activity.id)")
            }
            .accessibilityIdentifier("feed-list")
        }
    }
}
```

### Code Sample: UI Test
```swift
import XCTest

final class PulseUITests: XCTestCase {
    func testNavigationToDetail() throws {
        let app = XCUIApplication()
        app.launch()
        
        let firstRow = app.buttons["activity-row-1"]
        XCTAssertTrue(firstRow.waitForExistence(timeout: 5))
        firstRow.tap()
        
        XCTAssertTrue(app.navigationBars["Details"].exists)
    }
}
```

### TODOs
- [ ] Add accessibility identifiers
- [ ] Write UI test for Feed → Detail navigation
- [ ] Test loading and error flows

---

## Step 21: Professional Testing Strategy

### Key Topics
- Test pyramid
- CI tradeoffs
- What not to test

### Reviewer Questions
- What do senior engineers avoid testing?
- Where is the highest ROI?

### Testing Strategy Guide
```
Unit Tests (70%):
- ViewModel logic
- Service implementations
- Data transformations
- Error handling

Integration Tests (20%):
- API client with real endpoints
- Data flow between layers

UI Tests (10%):
- Critical user flows only
- Navigation paths
- Error recovery
```

### TODOs
- [ ] Review test coverage vs confidence
- [ ] Decide which tests to remove or keep
- [ ] Optimize test execution time

---

## Quick Reference: SwiftUI Property Wrappers

| Wrapper | Purpose | Owner |
|---------|---------|-------|
| `@State` | Local view state | View |
| `@Binding` | Two-way connection | Parent |
| `@StateObject` | Create observable | View |
| `@ObservedObject` | Observe existing | Parent |
| `@EnvironmentObject` | Global state | App |
| `@Environment` | System values | System |

---

## Quick Reference: Common Patterns

### MVVM Flow
```
View → ViewModel → Service → API
     ← (Published) ←        ← 
```

### Navigation Pattern
```swift
NavigationStack {
    List {
        NavigationLink(value: item) {
            RowView(item: item)
        }
    }
    .navigationDestination(for: Item.self) { item in
        DetailView(item: item)
    }
}
```

### Async Pattern
```swift
.task {
    await viewModel.load()
}
```

---

**End of Roadmap**

*Save this document for offline use. Each step builds on the previous, so follow in order for best results.*