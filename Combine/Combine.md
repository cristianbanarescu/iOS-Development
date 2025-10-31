# Combine - Functional reactive programming

## What is reactive programming? What is Combine?

- Reactive programming = declarative programming focused around data streams and the propagation of changes. (‘React to changes’)
- Reactive = respond to and manage async data and events in a declarative and data-driven way
- Declarative programming - focus on what to do rather than how to do it (like SwiftUI vs UIKit)
- Non-blocking, event-driven processing
- Combine > use it for async and event-driven code
- More predictable codebase + excel at handling asynchronous operations like: network requests, user input, real-time updates.
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
- If you don't have a subscription there is no point in having a publisher

## Core Concepts of Combine 

### Publishers

- Publisher - abstract representations of async data streams; emit events/items over time ; initiates the data stream (e.g. emit user input)
- PassthroughSubject
- CurrentValueSubject -> retains the last value sent
- @Published (SwiftUI)
- Timer publisher
- NotificationCenter publisher
- URLSession publisher (`URLSession.shared.dataTaskPublisher`)
- [0, 1, 2].publisher
- Just
- Future
- AnyPublisher<..., ...> -> generic type of publisher 

### Subscribers

- Subscribers - consume the values emitted over time ; listens to the data stream and processes and responds to the emitted items
- .sink
- .assign(on: , to: )
- .assign(on: )

### Subjects 

- Subject - special type that is a Publisher AND can also be a Subscriber
- PassthroughSubject
- CurrentValueSubject -> retains the last value sent
- send -> use it to publish a value
- Use the Subject protocol to create a custom Subject

### Operators

- Operators - chainable transformations - map, filter, combineLatest, zip (transform and manipulate data)
- .tryMap + catch -> used instead of map when you want to throw errors and catch them + handle them
- .mapError -> same, used for error handling
- .map -> which basically lets you apply some changes on a publisher ; also it returns a new publisher
- .compactMap -> same as you would apply for an array but here you'll apply it for a publisher
- .filter -> same as you would apply for an array but here you'll apply it for a publisher
- Publishers.Merge -> combines 2 publishers of the same type of emitted data
- .debounce -> publish elements only after some time interval elapses between events; useful for high-volume streams of data
- .combineLatest -> 'join 2 publishers'
- .zip 
- Publishers.Zip, Zip3, Zip4 -> create 'pairs' of publishers
- .switchToLatest
- .replaceError
- .retry -> retry to emit values
- .throttle -> minimize the amount of data to process
- .eraseToAnyPublisher()
- .share() -> can combine multiple subscribers
- you can create custom operators by simply adding extensions on the Publisher type. See example below
- .print() -> debug Combine code
- .breakpointOnError() and .breakpoint() to actually set breakpoints
- .handleEvents() -> check what events take place (e.g receiving an output)


### Code samples

```swift
// Custom operators

extension Publisher where Output == Int {
    func filterEvenNumbers() -> AnyPublisher<Int, Failure> {
        filter({ $0.isMultiple(of: 2) })
            .eraseToAnyPublisher()
    }
}

let evenNumbers = [1, 3, 5, 7, 9, 10, 14, 18, 22, 26].publisher.filterEvenNumbers()

```

### Notes

- Publishers and Subscribers are just abstractions (protocols) for working with data streams. There are built-in ones and you can also create your own custom ones if you need
- When you attach a subscriber to a publisher, you created a subscription and you'll need to store it somewhere in order to make the subscription work; subscriptions can be cancelled
- Subscriptions will be cancelled automatically when the object that stores them is deallocated
- When you 'hold on' to a subscription (ie have a reference to it) you can cancel the subscription by setting that reference to nil (or in a view controller when the VC is dismissed/you leave the screen)

## Useful resource

- [Discover Combine](https://www.swiftbysundell.com/discover/combine/?utm_source=chatgpt.com)
- [Future of Reactive Programming](https://medium.com/%40mumensh/the-future-of-reactive-programming-in-swift-cedb0d52ff05)
- [Learn Combine for Swift in 6 hours](https://www.swiftful-thinking.com/blog/learn-combine-for-swift-in-6-hours)
- [Combine framework tutorial - Karin Prater](https://www.youtube.com/playlist?list=PLWHegwAgjOkoIMgZ7QF_SHUtEB_rWXtH0)



