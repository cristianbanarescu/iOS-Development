# SwiftUI Interview Questions & Answers

Generated using Claude.

## Basics & Fundamentals

### Q1: What is SwiftUI and how does it differ from UIKit?

**Answer:** SwiftUI is Apple's declarative UI framework. Instead of imperatively creating and updating views like UIKit, you declare what the UI should look like based on state. SwiftUI automatically handles updates when state changes. It's cross-platform (iOS, macOS, watchOS, tvOS) and uses structs instead of classes for views.

---

### Q2: Why are SwiftUI views structs and not classes?

**Answer:** Views are structs for performance and simplicity. Structs are value types, cheaper to create/destroy, and their immutability makes state management predictable. SwiftUI creates and destroys views frequently, so lightweight structs are ideal.

---

### Q3: What is the `body` property in a SwiftUI view?

**Answer:** The `body` is a computed property that returns a view hierarchy. SwiftUI calls it whenever state changes to rebuild the UI. It must return a single view (but that view can contain many children).

```swift
var body: some View {
    VStack {
        Text("Hello")
        Text("World")
    }
}
```

---

## State Management

### Q4: Explain the difference between `@State` and `@Binding`.

**Answer:** 
- `@State`: Creates and owns local state within a view. Use for private, view-specific data.
- `@Binding`: Creates a two-way connection to state owned by a parent. Allows child views to read and write parent's state without owning it.

```swift
struct ParentView: View {
    @State private var isOn = false
    
    var body: some View {
        ChildView(isOn: $isOn) // Pass binding with $
    }
}

struct ChildView: View {
    @Binding var isOn: Bool // Receives binding
}
```

---

### Q5: When do you use `@StateObject` vs `@ObservedObject`?

**Answer:**
- `@StateObject`: Creates and owns the observable object. Use when the view is responsible for the object's lifecycle.
- `@ObservedObject`: Observes an existing object passed from a parent. The parent owns it.

```swift
struct ParentView: View {
    @StateObject private var viewModel = ViewModel() // Creates it
}

struct ChildView: View {
    @ObservedObject var viewModel: ViewModel // Receives it
}
```

---

### Q6: What is `@EnvironmentObject` and when should you use it?

**Answer:** It's for sharing objects across many views without passing them explicitly through each level. Injected at the root and accessed anywhere in the hierarchy. Use for truly global state like user settings or authentication.

```swift
@main
struct MyApp: App {
    @StateObject private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settings)
        }
    }
}

struct SomeDeepView: View {
    @EnvironmentObject var settings: AppSettings
}
```

---

### Q7: What happens if you forget `@State` on a variable that should trigger UI updates?

**Answer:** The UI won't update when the variable changes because SwiftUI doesn't track it. Only property wrappers like `@State`, `@Published`, etc. trigger view invalidation.

---

## View Lifecycle

### Q8: What's the difference between `.onAppear` and `.task`?

**Answer:**
- `.onAppear`: Fires when view appears. Synchronous, not automatically cancelled.
- `.task`: Designed for async work, automatically cancelled when view disappears. Preferred for loading data.

```swift
.onAppear {
    loadData() // Must be sync or wrap in Task
}

.task {
    await loadData() // Native async support, auto-cancelled
}
```

---

### Q9: How do you prevent a view from re-rendering unnecessarily?

**Answer:** 
1. Avoid unnecessary `@State` or `@Published` properties
2. Use `Equatable` views with `==` comparisons
3. Break large views into smaller, focused components
4. Use `let` instead of `@State` for immutable data

---

## Navigation

### Q10: How does navigation work in SwiftUI?

**Answer:** Use `NavigationStack` (iOS 16+) with `NavigationLink` or programmatic navigation. For simple navigation, use value-based links. For complex flows, manage navigation state with a path.

```swift
NavigationStack {
    List(items) { item in
        NavigationLink(value: item) {
            Text(item.name)
        }
    }
    .navigationDestination(for: Item.self) { item in
        DetailView(item: item)
    }
}
```

---

### Q11: How do you navigate programmatically?

**Answer:** Manage a navigation path with `NavigationPath` or an array, then mutate it to trigger navigation.

```swift
@State private var path = NavigationPath()

NavigationStack(path: $path) {
    Button("Go to detail") {
        path.append(item)
    }
}
```

---

## Lists & Collections

### Q12: Why must list items conform to `Identifiable`?

**Answer:** SwiftUI uses identity to track which items changed, moved, or were deleted. This enables smooth animations and prevents UI bugs when the data source updates.

```swift
struct Item: Identifiable {
    let id: UUID
    let name: String
}
```

---

### Q13: What's the difference between `List` and `ForEach`?

**Answer:**
- `List`: A container that provides scrolling and platform-specific styling
- `ForEach`: Just iterates over data, can be used inside any container

```swift
List(items) { item in  // List handles both
    Text(item.name)
}

VStack {
    ForEach(items) { item in  // ForEach only iterates
        Text(item.name)
    }
}
```

---

## Async & Networking

### Q14: How do you handle async operations in SwiftUI?

**Answer:** Use `async/await` with `.task` modifier for automatic lifecycle management, or wrap in `Task` if called from non-async contexts.

```swift
.task {
    await viewModel.loadData()
}

// Or in a button:
Button("Load") {
    Task {
        await viewModel.loadData()
    }
}
```

---

### Q15: How do you ensure UI updates happen on the main thread?

**Answer:** Mark your ViewModel with `@MainActor` or explicitly dispatch to main thread. SwiftUI views must update on the main thread.

```swift
@MainActor
class ViewModel: ObservableObject {
    @Published var data: [Item] = []
    
    func load() async {
        // All code here runs on main thread
        data = await fetchData()
    }
}
```

---

## Modifiers & Styling

### Q16: Why does modifier order matter in SwiftUI?

**Answer:** Modifiers wrap views in order, creating new views at each step. The order changes what gets modified.

```swift
Text("Hello")
    .padding()
    .background(Color.blue)  // Background around padding

Text("Hello")
    .background(Color.blue)
    .padding()  // Padding around background
```

---

### Q17: How do you create a reusable modifier?

**Answer:** Create a `ViewModifier` and add an extension for convenience.

```swift
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 2)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardModifier())
    }
}

// Usage:
Text("Hello").cardStyle()
```

---

## MVVM & Architecture

### Q18: What is MVVM in SwiftUI and why use it?

**Answer:** MVVM separates UI (View) from business logic (ViewModel) and data (Model). ViewModels are testable, reusable, and keep views simple. Models are data structures, Views display data, ViewModels handle logic and state.

```swift
// Model
struct User: Identifiable {
    let id: UUID
    let name: String
}

// ViewModel
@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func loadUsers() async {
        // Business logic
    }
}

// View
struct UserView: View {
    @StateObject private var viewModel = UserViewModel()
    
    var body: some View {
        List(viewModel.users) { user in
            Text(user.name)
        }
    }
}
```

---

### Q19: How do you make ViewModels testable?

**Answer:** Use dependency injection with protocols for services, avoid direct dependencies on concrete types.

```swift
protocol DataService {
    func fetchData() async throws -> [Item]
}

class ViewModel: ObservableObject {
    private let service: DataService
    
    init(service: DataService) {
        self.service = service
    }
}

// In tests:
class MockService: DataService {
    func fetchData() async throws -> [Item] {
        return [Item(id: 1, name: "Test")]
    }
}
```

---

## Animations

### Q20: How do you animate state changes?

**Answer:** Use `withAnimation` to animate explicit state changes, or add `.animation` modifier for implicit animations.

```swift
// Explicit
withAnimation {
    isExpanded.toggle()
}

// Implicit
Circle()
    .fill(isOn ? .blue : .red)
    .animation(.easeInOut, value: isOn)
```

---

### Q21: What's the difference between implicit and explicit animations?

**Answer:**
- **Implicit**: Automatically animates any property changes (`.animation` modifier)
- **Explicit**: Only animates changes inside `withAnimation` block

Explicit is more predictable and preferred for complex interactions.

---

## Data Flow

### Q22: What does "data down, actions up" mean?

**Answer:** Parent views pass immutable data down to children via properties. Children signal changes back up via closures or bindings, but don't modify parent data directly. Keeps data flow unidirectional and predictable.

```swift
struct Parent: View {
    @State private var count = 0
    
    var body: some View {
        Child(count: count) { // Data down
            count += 1 // Action up
        }
    }
}

struct Child: View {
    let count: Int
    let onIncrement: () -> Void
    
    var body: some View {
        Button("Count: \(count)") {
            onIncrement()
        }
    }
}
```

---

### Q23: When should you avoid using `@Binding`?

**Answer:** Avoid bindings for:
- Navigation state (use closures)
- One-way data flow (use closures for actions)
- Complex state updates (use ViewModels instead)

Bindings are best for simple two-way controls like toggles and text fields.

---

## Performance

### Q24: How do you optimize a slow List with many items?

**Answer:**
1. Ensure items are `Identifiable` with stable IDs
2. Keep row views simple and lightweight
3. Avoid complex calculations in the view body
4. Use `LazyVStack` instead of `VStack` for large scrolling content
5. Move expensive work to ViewModels

---

### Q25: What causes excessive view re-renders?

**Answer:**
- Unnecessary `@Published` properties
- `@State` for data that doesn't affect UI
- Large views with too many responsibilities
- ObservableObjects that change too frequently
- Not breaking views into smaller components

---

## Testing

### Q26: What should you unit test in a SwiftUI app?

**Answer:** Test ViewModels, business logic, data transformations, and service layers. Don't test SwiftUI views directly—use UI tests for that.

```swift
@Test func testLoadUsers() async {
    let mockService = MockUserService()
    let viewModel = UserViewModel(service: mockService)
    
    await viewModel.loadUsers()
    
    #expect(viewModel.users.count == 2)
    #expect(viewModel.errorMessage == nil)
}
```

---

### Q27: How do you test async code in ViewModels?

**Answer:** Use `async` test functions and `await` the async operations.

```swift
@Test func testAsyncLoad() async throws {
    let viewModel = ViewModel()
    await viewModel.loadData()
    #expect(viewModel.isLoading == false)
}
```

---

## Advanced Topics

### Q28: What is `@Published` and when do you use it?

**Answer:** It marks properties in `ObservableObject` that should trigger view updates when changed. Use it for any state that affects the UI.

```swift
class ViewModel: ObservableObject {
    @Published var items: [Item] = []  // Triggers updates
    private var cache: [Item] = []     // Doesn't trigger updates
}
```

---

### Q29: How do you handle keyboard focus in forms?

**Answer:** Use `@FocusState` to track and control which field is focused.

```swift
@FocusState private var focusedField: Field?

enum Field {
    case username, password
}

TextField("Username", text: $username)
    .focused($focusedField, equals: .username)

TextField("Password", text: $password)
    .focused($focusedField, equals: .password)

Button("Next") {
    focusedField = .password
}
```

---

### Q30: What's the difference between `Sheet` and `FullScreenCover`?

**Answer:**
- `Sheet`: Modal that can be dismissed by swiping down, shows previous screen behind on iPad
- `FullScreenCover`: Covers entire screen, must be dismissed programmatically

```swift
.sheet(isPresented: $showSheet) {
    DetailView()
}

.fullScreenCover(isPresented: $showCover) {
    OnboardingView()
}
```

---

## Common Pitfalls

### Q31: Why shouldn't you perform side effects directly in the view body?

**Answer:** The body can be called multiple times during a single render cycle. Side effects should go in lifecycle methods like `.onAppear`, `.task`, or button actions, not in computed properties.

```swift
// ❌ Wrong
var body: some View {
    let _ = print("Rendering") // Side effect
    Text("Hello")
}

// ✅ Correct
var body: some View {
    Text("Hello")
        .onAppear {
            print("Appeared")
        }
}
```

---

### Q32: What's wrong with this code?

```swift
struct ContentView: View {
    @State var items = [Item]()
    
    var body: some View {
        List(items) { item in
            Text(item.name)
        }
        .onAppear {
            items = loadItems() // Synchronous
        }
    }
}
```

**Answer:** If `loadItems()` does any networking or heavy work, it blocks the main thread. Use `.task` with async/await instead:

```swift
.task {
    items = await loadItems()
}
```

---

### Q33: Why is this TextField not updating?

```swift
struct FormView: View {
    var name: String
    
    var body: some View {
        TextField("Name", text: $name) // Error: Cannot pass immutable value as binding
    }
}
```

**Answer:** `name` needs to be `@State` or `@Binding` to be mutable and trigger updates.

```swift
@State private var name: String = ""
// or
@Binding var name: String
```

---

## Best Practices

### Q34: What makes a good SwiftUI view?

**Answer:**
- Single responsibility
- No business logic (belongs in ViewModel)
- Composable and reusable
- Minimal state
- Descriptive naming
- No side effects in body

---

### Q35: How do you structure a large SwiftUI project?

**Answer:**
```
App/
  ├── Views/
  │   ├── Feed/
  │   ├── Detail/
  │   └── Shared/
  ├── ViewModels/
  ├── Models/
  ├── Services/
  ├── Extensions/
  └── Tests/
```

Organize by feature, keep ViewModels testable, use dependency injection, and separate networking into services.

---

## Quick Tips for Interviews

1. **Be concise** - Don't over-explain
2. **Show code** - Examples are better than long descriptions
3. **Mention tradeoffs** - Show you understand when to use what
4. **Think aloud** - Explain your reasoning
5. **Ask clarifying questions** - "Are we optimizing for testability or simplicity?"

---

**Common Follow-up Questions:**
- "How would you test this?"
- "What are the performance implications?"
- "How would you handle errors?"
- "What changes for iPad or macOS?"

Be ready to discuss alternatives and explain *why* you chose your approach!