# SwiftUI Learning Project using ChatGPT

## Prompt

I want you to act like a very experienced senior iOS engineer and SwiftUI expert.

I am building a SwiftUI learning project from scratch and I want to practice SwiftUI end-to-end by implementing a real app step by step, not just reading explanations.

Assume I may paste code here for review and you should respond like a strict but helpful code reviewer. I may not be able to directly add .swift files for you to review but I'd rather paste the code that contains the logic. When I paste in some code and ask you a question about my code I need you to answer my question and give me helpful answers so that I can really understand the problem behind my code and also to learn SwiftUI concepts along the way.

Project constraints:
- Target platform: iOS 26+
- UI framework: SwiftUI only
- Language: Swift
- Use Apple-native APIs only (no third-party libraries)
- Networking must use URLSession + async/await
- Use a public API that requires no API keys, no registration, and no authentication
- The chosen API is JSONPlaceholder (GET, POST, PUT, DELETE)
- Always use Apple's documentation for API references 

Project goals:
- Learn SwiftUI by building views, layouts, and reusable components
- Understand state management (@State, @Binding, @StateObject, @ObservedObject, @EnvironmentObject)
- Learn SwiftUI view lifecycle and refresh behavior
- Implement navigation using NavigationStack
- Handle async work, loading states, error states, and pull-to-refresh
- Implement animations and transitions
- Persist simple app state using UserDefaults
- Apply MVVM architecture with protocol-based services and dependency injection
- Design the app for testability

App concept:
- A feed-based app (working name “Pulse”)
- Fetch a list of items from an API
- Navigate to a detail screen
- Create and edit items using forms
- Fake write operations (local state updates) are acceptable

Testing requirements:
- Write unit tests for ViewModels and business logic
- Write async unit tests for networking
- Mock services via protocols
- Add UI tests for navigation and main flows
- Follow the test pyramid (more unit tests, fewer UI tests)

Teaching style:
- Guide me step by step
- Introduce concepts only when needed
- Explain *why* decisions are made
- Point out common SwiftUI mistakes and fix them
- Treat my code like a code review
- Ask me reasoning questions as we go

Current progress:
- Project was created, some code was added and I finished Step 1 from the Roadmap below.

Using all the above & below information about what we're building/improving, please continue from Step 2 from the Roadmap.

## Goals
- Practice SwiftUI end-to-end
- Learn modern iOS architecture
- Build testable, production-quality code

## Constraints
- iOS 26+
- SwiftUI only
- Apple-native APIs
- No third-party libraries
- Public API (no keys, no auth)

## App Concept
- Feed-based app called "Pulse". *A modern SwiftUI app that fetches, displays, edits, and persists data from an API.*. Think of it as a **lightweight “activity / posts” app**, similar to a simplified social feed or task/activity tracker.
- Fetch, display, edit, create data

## API
- JSONPlaceholder
- GET / POST / PUT / DELETE

## Architecture
- MVVM
- Protocol-based services
- Dependency injection

## SwiftUI Topics
- App lifecycle
- Views & layout
- State & bindings
- Async/await
- Networking
- Animations
- Persistence
- Testing

## Roadmap

### 1. Project & App Structure

* SwiftUI App lifecycle (`@main`, `App` protocol)
* `Scene`, `WindowGroup`
* File and folder organization (Views, Models, ViewModels, Services)
* Preview system (`#Preview` / `PreviewProvider`)

---

### 2. Core View Building

* `View` protocol
* Basic layout containers:

  * `VStack`, `HStack`, `ZStack`
  * `Spacer`, `Divider`
* Text, Image, Button basics
* Modifiers (order matters!)
* Custom reusable views

---

### 3. State Management Fundamentals

* `@State`
* View invalidation & refresh behavior
* Value vs reference semantics in SwiftUI
* Why views are structs
* Common `@State` mistakes

---

### 4. Data Flow Between Views

* `@Binding`
* Passing data down vs actions up
* Parent–child communication patterns
* `@StateObject` vs `@ObservedObject`
* When bindings are the *wrong* solution

---

### 5. Lists & Dynamic Views

* `List`, `ForEach`
* Identifiable models
* Dynamic row updates
* Deleting, reordering rows
* Performance considerations

---

### 6. Navigation

* `NavigationStack`
* `NavigationLink`
* Programmatic navigation
* Passing data through navigation
* Navigation state modeling

---

### 7. User Input

* `TextField`, `SecureField`
* `Toggle`, `Picker`
* Focus management (`@FocusState`)
* Form validation patterns

---

### 8. View Composition & Architecture

* MVVM in SwiftUI
* ViewModels responsibility boundaries
* Why “fat views” are a problem
* Testing-friendly design decisions

---

### 9. Observable State & Data Models

* `ObservableObject`
* `@Published`
* `@StateObject` lifecycle
* Reference vs value types in models
* Avoiding unintended re-renders

---

### 10. Async & Concurrency

* `async / await`
* `Task {}` vs `.task`
* Structured concurrency
* Cancellation
* Error handling (`do / catch`)

---

### 11. Networking & API Fetching

* URLSession basics
* Codable models
* Decoding JSON
* Loading, success, error states
* Dependency injection for services

---

### 12. View Lifecycle Awareness

* `.onAppear`, `.onDisappear`
* `.task(id:)`
* Handling refresh & reloading
* Pull-to-refresh (`.refreshable`)

---

### 13. Animations

* Implicit animations
* Explicit animations
* `withAnimation`
* Transitions
* Matched geometry effects (intro)
* Performance pitfalls

---

### 14. Conditional UI & State-driven Design

* `if/else` in views
* Empty states
* Loading placeholders (skeletons)
* Error UI patterns

---

### 15. Environment & App-wide State

* `@Environment`
* `@EnvironmentObject`
* Light/Dark mode handling
* Accessibility basics

---

### 16. Persistence (Intro Level)

* `UserDefaults`
* Simple local caching
* State restoration concepts

---

### 17. Debugging & Best Practices

* SwiftUI preview debugging
* Logging state changes
* Common SwiftUI bugs & how to recognize them
* Performance red flags

---

### 18. Polishing & Production Readiness

* Reusable styles
* Custom view modifiers
* Error handling UX
* Clean architecture recap

---

## 🧪 19. Unit Testing (SwiftUI-Focused)

* What *should* and *should not* be unit tested in SwiftUI
* Testing ViewModels (business logic)
* Testing async code (`async` tests)
* Mocking services and API clients
* Dependency injection for testability
* Avoiding UI in unit tests
* Common testing anti-patterns

---

## 📱 20. UI Testing

* XCUITest basics
* Accessibility identifiers
* Writing stable UI tests
* Testing navigation flows
* Testing async UI states (loading, error)
* Reducing flakiness
* When UI tests are worth the cost

---

## 🧠 21. Professional Testing Strategy (Bonus)

* Test pyramid for SwiftUI apps
* What senior engineers *don’t* test
* CI considerations
* Fast feedback vs full coverage
* Real-world tradeoffs

## Why This App Is Ideal for Learning SwiftUI

This app naturally forces us to touch **every major SwiftUI concept** without feeling artificial.

### Core Features (Mapped to Topics)

#### 1. Feed Screen

* List of items fetched from an API
* Pull-to-refresh
* Loading / empty / error states
* Animations when items appear
* Async data loading

➡️ `List`, `ForEach`, `.refreshable`, `.task`, async/await, networking

---

#### 2. Detail Screen

* Navigate from list → detail
* Pass data through navigation
* Editable fields
* Save changes back to state

➡️ `NavigationStack`, `NavigationLink`, `@Binding`, MVVM

---

#### 3. Create / Edit Item

* Form with inputs
* Validation
* Save & cancel flows
* Reusable components

➡️ `TextField`, `Toggle`, `Picker`, `@State`, `@FocusState`

---

#### 4. Global App State

* User settings (e.g. display preferences)
* Shared state via environment
* Persistence via `UserDefaults`

➡️ `@EnvironmentObject`, persistence, dependency injection

---

#### 5. Animations & Transitions

* Animated list insertions
* State-based animations
* Transitions between states

➡️ `withAnimation`, transitions, matched geometry (intro)

---

#### 6. Architecture & Testability

* MVVM with clean separation
* Injectable services
* Mock API clients

➡️ `ObservableObject`, `@Published`, clean architecture

---

#### 7. Testing

* Unit tests for ViewModels
* Async tests for networking
* UI tests for navigation and flows

➡️ Swift Testing, XCUITest, mocking, test pyramid

---

## High-Level Architecture

```
Pulse/
├── App/
│   └── PulseApp.swift
├── Models/
│   └── Activity.swift
├── Views/
│   ├── Feed/
│   │   ├── FeedView.swift
│   │   └── ActivityRowView.swift
│   ├── Detail/
│   │   └── ActivityDetailView.swift
│   ├── CreateEdit/
│   │   └── EditActivityView.swift
│   └── Shared/
│       └── LoadingView.swift
├── ViewModels/
│   ├── FeedViewModel.swift
│   └── ActivityDetailViewModel.swift
├── Services/
│   ├── ActivityService.swift
│   └── APIClient.swift
├── Tests/
│   ├── Unit/
│   └── UI/
```