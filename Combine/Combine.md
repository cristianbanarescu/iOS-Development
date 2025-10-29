# Combine 
## Functional reactive programming

- Reactive programming = declarative programming focused around data streams and the propagation of changes. (‘React to changes’)
- More predictable codebase + excel at handling asynchronous operations like: network requests, user input, real-time updates.
- Publisher - abstract representations of async data streams; Subscribers - consume the values emitted over time 
- Operators - chainable transformations - map, filter, combineLatest, zip
- iOS 17 and above + SwiftUI: seems worthless; you already have Observable, ObservableObject to manage SwiftUI state + Async await syntax
- Apple is pushing towards async/await 
- If you still need it, it works and is well ‘tested’ and used by possibly lots of legacy projects
- Hard to integrate with Swift 6 language mode 
- Combine can be around for  a while to support older projects and UIKit based projects 
- SwiftUI relies on the Observation framework instead of using Combine
- Combine and async/await can be used together because they serve different purposes: Combine > observing value/events + other helpers around this ; async/await > structured concurrency - managing async vs sync execution flow
- Use Combine to propagate changes to different parts of the app
- Has backpressure management (e.g. debounce)
- It is still worth learning it. There seem to be projects using it so it is worth at least knowing the core concepts, not too many details 
- With Combine, you connect streams of data directly to the UI components, bypassing delegates, closures, notifications
- Functional reactive programming framework 
- Combine - good for observing things and receiving changes/updates (e.g when a user taps on a button, when a property changes, when a notification is sent via NotificationCenter)
- Output of changes/changes received can be transformed before used in the UI if needed (using operators)
- Common use case of Combine: Networking layers - treat a data task as a publisher, transform their output and eventually forward this output to the UI 
- Combine was intended to react to streams of values caused by state changes
- Combine - various operations can be transformed into publishers that emit values and events
- E.g flow: publisher that performs a network call to a given URL, which is then connected to operators that decode the data from the response and then the output is then observed 
- Combine introduced at the same time with SwiftUI
- Foundation’s URLSession API has Combine support 

### Useful resource

- [Discover Combine](https://www.swiftbysundell.com/discover/combine/?utm_source=chatgpt.com)
- [Future of Reactive Programming](https://medium.com/%40mumensh/the-future-of-reactive-programming-in-swift-cedb0d52ff05)
- [Learn Combine for Swift in 6 hours](https://www.swiftful-thinking.com/blog/learn-combine-for-swift-in-6-hours)
- [Combine framework tutorial - Karin Prater](https://www.youtube.com/playlist?list=PLWHegwAgjOkoIMgZ7QF_SHUtEB_rWXtH0)



