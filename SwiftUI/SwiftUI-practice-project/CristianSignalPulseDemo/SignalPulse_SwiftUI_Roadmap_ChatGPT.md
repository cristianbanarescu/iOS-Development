# SignalPulse – SwiftUI Learning Roadmap (Tasks & Questions Only)

Generated using ChatGPT. For demo/practice mode only.

## 1. Project & App Setup
### TODO
- Create a new SwiftUI App project called `Signal`
- Create folders: App, Models, Views, ViewModels, Services
- Move `SignalApp.swift` into `App/`
- Create `SignalRootView` and make it the app entry point

### Questions
- Why is the App layer a better boundary than using ContentView directly?
- What happens when the root view is recreated?

---

## 2. Core View Building
### TODO
- Build `SignalRowView`
- Add title, body, date
- Use VStack / HStack properly
- Apply spacing and modifiers

### Questions
- Why does modifier order matter?
- Which modifier placement could break layout?

---

## 3. State Basics
### TODO
- Store a temporary list in a parent view
- Render rows using ForEach
- Add a button to append items

### Questions
- Why must the list be @State?
- What triggers a view refresh?

---

## 4. Data Flow
### TODO
- Pass data down into `SignalRowView`
- Pass actions up via closures
- Handle row selection in parent

### Questions
- Why not mutate state in the row?
- What breaks if the row owns state?

---

## 5. Lists & Dynamic Content
### TODO
- Replace layout with List
- Support delete and reorder
- Keep UI stable during updates

### Questions
- Why must models be Identifiable?
- What issues arise from unstable IDs?

---

## 6. Navigation
### TODO
- Wrap app in NavigationStack
- Navigate to a detail view
- Pass selected model forward

### Questions
- Why is navigation state-driven?
- Why avoid imperative navigation?

---

## 7. User Input
### TODO
- Create EditSignalView
- Add inputs for title, body, flagged
- Add Save / Cancel logic
- Validate input

### Questions
- Where should validation live?
- Why is FocusState important?

---

## 8. MVVM
### TODO
- Create SignalListViewModel
- Move state out of the view
- Bind view to ViewModel

### Questions
- What logic stays in the view?
- When is a ViewModel too fat?

---

## 9. Observable State
### TODO
- Make ViewModel ObservableObject
- Use @Published
- Use @StateObject correctly

### Questions
- Why StateObject vs ObservedObject?
- What bugs appear if misused?

---

## 10. Async & Concurrency
### TODO
- Add async loading
- Show loading UI
- Handle cancellation

### Questions
- When does .task re-run?
- Why care about cancellation?

---

## 11. Networking
### TODO
- Create service protocol
- Implement URLSession client
- Decode JSONPlaceholder data
- Inject service

### Questions
- Why protocol-first?
- Where should decoding errors be handled?

---

## 12. View Lifecycle
### TODO
- Load data on first appearance
- Prevent duplicate fetches
- Add pull-to-refresh

### Questions
- Why is onAppear often wrong?
- What does .task(id:) solve?

---

## 13. Animations
### TODO
- Animate inserts and deletes
- Animate loading transitions

### Questions
- When do implicit animations fail?
- Why animate state, not views?

---

## 14. Conditional UI
### TODO
- Add loading, empty, error states
- Drive UI purely from state

### Questions
- Why avoid multiple booleans?
- What’s the danger of ad-hoc UI logic?

---

## 15. Environment
### TODO
- Add a global app setting
- Use EnvironmentObject
- Inject at app level

### Questions
- When is EnvironmentObject a smell?
- What are safer alternatives?

---

## 16. Persistence
### TODO
- Persist setting with UserDefaults
- Restore on launch
- Keep persistence out of views

### Questions
- Why shouldn’t views talk to UserDefaults?
- What breaks if they do?

---

## 17. Debugging
### TODO
- Add logging
- Clean unused state
- Fix previews

### Questions
- Why do previews fail often?
- How to debug SwiftUI state fast?

---

## 18. Unit Testing
### TODO
- Test ViewModels
- Mock services
- Test async logic

### Questions
- What should not be unit tested?
- Why UI tests are not a replacement?

---

## 19. UI Testing
### TODO
- Add accessibility identifiers
- Test navigation flows
- Avoid fixed delays

### Questions
- Why are UI tests fragile?
- When are they worth it?

---

## 20. Final Polish
### TODO
- Extract reusable modifiers
- Clean naming
- Final architecture review

### Questions
- What would you refactor first?
- What would you intentionally leave imperfect?
