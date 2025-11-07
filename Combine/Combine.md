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
- They don't emit values if they don't have a subscription attached to them
- Sequence publishers actually stop publishing values after last element was published. e.g [1, 2, 3].publisher won't publish anything after "3". The subscription is also released after that

### Subscribers

- Subscribers - consume the values emitted over time ; listens to the data stream and processes and responds to the emitted items
- How to create a subscription?
    - .sink
    - .assign(on: , to: )
    - .assign(on: )
- How to stop a data stream?
    - subscription.cancel()
    - subscription = nil 
    - throw an error (e.g. tryMap + throw some error. see examples below)
- Subscribers decide how much data they want to receive 
- Subcription protocol
    - the 'glue' that puts together a Publisher and a Subscriber
    - this makes the flow of data work
    - it is the contract between publishers and subscribers

### Subjects 

- Subject - special type that is a Publisher AND can also be a Subscriber
- PassthroughSubject
- CurrentValueSubject -> retains the last value sent
- send -> use it to publish a value
- Use the Subject protocol to create a custom Subject
- Subject = A publisher that exposes a method (send) for outside callers to publish elements. https://developer.apple.com/documentation/combine/subject
- A subject is a publisher that you can use to ”inject” values into a stream, by calling its send(_:) method. This can be useful for adapting existing imperative code to the Combine model.

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
- .subscribe(on: ) -> specifies which thread to use to send values. e.g: .subscribe(on: DispatchQueue.global())
- .receive(on: ) -> specifies on which thread to receive values. Useful if you have a publisher that emits values on a background thread (URLSession.shared.dataTaskPublisher) and you want to receive values on another thread (e.g. Main Thread to update some UI)
- .scan -> to transform values from an upstream publisher 
- .removeDuplicates


### Code samples

```swift

// EXAMPLE: Array publisher 

let stringPublisher = ["1", "2", "A", "B", "3"].publisher
let stringSub = stringPublisher.sink { receivedValue in
    print(receivedValue)
}

```

```swift
// EXAMPLE: Just publisher - emit an output just once and then finish

// https://medium.com/@amitaswal87/combine-in-swift-third-part-types-of-publishers-and-subscribers-40175524b601

let publisher = Just("hey") // A publisher that emits an output to each subscriber just once, and then finishes.

let subscriber = publisher.sink { valueReceived in
    print(valueReceived)
}

```

```swift
// EXAMPLE: Timer publiser

let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common) // connectable publisher
let cancellableTimer = timerPublisher.autoconnect().sink { date in // cancellableTimer is actually subscribing to the Publisher by using .sink
    // subscribers don’t receive any values until after a call to connect(). For convenience when working with a single subscriber, the autoconnect() operator performs the connect() call when attached to by the subscriber.
    print(date)
}

```

```swift
// EXAMPLE: Timer publisher + subscriptions and cancellation

@MainActor
class MyClass {
    private var cancellables: Set<AnyCancellable> = []
    private var timerSubscription2: AnyCancellable? = nil
    
    func postTimerDate() {
        timerPublisher.autoconnect().sink { date in // .sink returns a 'subscription' that needs to be kept alive so that you receive events/values from publishers
            print(date) 
        }.store(in: &cancellables) // need to store the subscription to the publisher (keep the subscription alive). if you don't store the subscription, you won't get values from it; Deallocation of the subscription (result from calling .sink on a publisher) will tear down the subscription stream.
    }
    
    func postTimerDateUsingStoredSubscription() {
        timerSubscription2 = timerPublisher.autoconnect().sink(receiveValue: { date in
            print(date)
        })
    }
    
    func cancelTimerSubscription2() {
        timerSubscription2?.cancel()    // this will cancel subscriptions and you won't print out any values     
    }
    
    func setTimerSubscription2ToNil() {
        timerSubscription2 = nil // this will cancel subscriptions and you won't print out any values
    }
}

```

```swift
// EXAMPLE: Custom operators

extension Publisher where Output == Int {
    func filterEvenNumbers() -> AnyPublisher<Int, Failure> {
        filter({ $0.isMultiple(of: 2) })
            .eraseToAnyPublisher()
    }
}

let evenNumbers = [1, 3, 5, 7, 9, 10, 14, 18, 22, 26].publisher.filterEvenNumbers()
```

```swift
// EXAMPLE: tryMap - error handling 

enum StringError: Error, CustomStringConvertible {
    case cannotConvertToInt
    
    var description: String {
        switch self {
        case .cannotConvertToInt:
            "Conversion to int is impossible"
        }
    }
}

let stringPublisher = ["1", "2", "A", "B", "3"].publisher

let publisherWithPossibleFailure = stringPublisher
    .tryMap { emittedString in // use tryMap when you want to throw errors inside
        let intValue = Int(emittedString)
        
        if let intValue {
            return intValue
        } else {
            throw StringError.cannotConvertToInt
        }
    }

let subscriptionForPossibleStringFailure = publisherWithPossibleFailure.sink { completion in // subscribe to receive values or error
    switch completion {
    case .finished:
        print("Done receiving elements")
    case .failure(let error as StringError):
        print(error.description)
    case .failure(_):
        print("general failure")
    }
} receiveValue: { receivedValue in
    print(receivedValue)
}

// Output:
1
2
Conversion to int is impossible
// once the publisher hits an error and emits it, it cannot emit any more values

// EXAMPLE: mapError

struct MyGenericError: Error { var wrappedError: Error }

let mapErrorSubscription = publisherWithPossibleFailure
    .mapError { error in
        return MyGenericError(wrappedError: error) // I receive a StringError and 'turn it' (map) into a MyGenericError
    }
    .sink { completion in
        switch completion {
        case .finished:
            print("finished emitting values")
        case .failure(let error):
            print(error.localizedDescription)
        }
    } receiveValue: { receivedValue in
        print(receivedValue)
    }

// Output:
1
2
The operation couldn’t be completed. (__lldb_expr_278.MyGenericError error 1.)
```

```swift
// EXAMPLE: Publishers.Merge

let firstPublisher = [1, 2, 3, 4, 5].publisher
let secondPublisher = Just(99)
let mergedPublisher = Publishers.Merge(firstPublisher, secondPublisher)

print("will print a merge of 2 publishers:")

let subscription = mergedPublisher.sink { value in
    print(value)
}

// Output:
will print a merge of 2 publishers:
1
2
3
4
5
99
```

```swift
// EXAMPLE: compactMap

let subscriptionWithCompactMap = stringPublisher // ["1", "2", "A", "B", "3"].publisher
    .compactMap { emittedString in // use compactMap when you want NON-nil values only
        let intValue = Int(emittedString)
        
        if let intValue {
            return intValue
        } else {
            return nil
        }
    }
    .sink { value in
        print(value)
    }

// Output:
1
2
3
```

```swift

// EXAMPLE: filter 
let filterPublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher

let subscriptionWithEvenNumbers = filterPublisher
    .filter { $0.isMultiple(of: 2) } // filter data emitted by the publisher
    .sink { value in
        print("received even number: \(value)")
    }

// Output:
received even number: 2
received even number: 4
received even number: 6
received even number: 8
received even number: 10
```

```swift
// EXAMPLE: Publishers.Zip + Zip3 (there's also Zip4)
// create pairs from different publishers

let publisherZip1 = [1, 2, 3].publisher
let publisherZip2 = ["a", "b", "c"].publisher

let subscriptionZip = Publishers.Zip(publisherZip1, publisherZip2)
    .sink { value in
        print(value) // (1, a), (2, b), (3, c)
    }

let publisherZip3 = [1.3, 23.12, 123.43].publisher

let subscriptionZip3 = Publishers.Zip3(publisherZip1, publisherZip2, publisherZip3)
    .sink { value in
        print(value) // (1, "a", 1.3) (2, "b", 23.12) (3, "c", 123.43)
    }
```

```swift

// EXAMPLE: replaceError

let publisherForReplaceError = ["1", "2", "A", "B", "3"].publisher

let subscriptionForReplaceError = publisherForReplaceError
    .tryMap { emittedString in // use tryMap when you want to throw errors inside
        let intValue = Int(emittedString)
        
        if let intValue {
            return intValue
        } else {
            throw StringError.cannotConvertToInt
        }
    }
    .replaceError(with: -100) // replace error with -100
    .sink { value in
        print(value)
    }

// Output:
1
2
-100
```

```swift

// EXAMPLE: retry + catch

let somePublisher = ["1", "2", "A", "B", "3"].publisher
let subscriptionForReplaceError2 = somePublisher
    .tryMap { emittedString in // use tryMap when you want to throw errors inside
        let intValue = Int(emittedString)
        
        if let intValue {
            return intValue
        } else {
            throw StringError.cannotConvertToInt
        }
    }
    .retry(3)
    .catch { error in
        return Just(-1) // this is 'delivered' only after retrying for 3 times
    }
    .sink { value in
        print(value)
    }

// Output:
1
2
// first retry:
1
2
// second retry:
1
2
// third retry:
1
2
// no more retries, 'just' emit a -1
-1
```

```swift

// EXAMPLE: debounce

let textChanges = PassthroughSubject<String, Never>() // lets you send value into a Combine pipeline
let cancellable = textChanges
    .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // delays forwarding values until there has been a 300ms pause in incoming events. If another value arrives before 300ms elapses, the timer resets and only the latest value after the quiet period is emitted.
    .sink { value in
        print("Debounced: \(value) at \(Date())")
    }


// Simulate quick typing
Task { @MainActor in
    textChanges.send("s")
    
    try? await Task.sleep(for: .seconds(0.1))
    textChanges.send("sw")
    
    try? await Task.sleep(for: .seconds(0.2))
    textChanges.send("swi") // this one emits
    
    try? await Task.sleep(for: .seconds(0.3))
    textChanges.send("swift") // this one emits
}

// Because of the debounce, only values that are followed by at least 300ms of silence will be emitted. In this sequence:
//  • "s" is followed by "sw" in 0.1s → not emitted.
//  • "sw" is followed by "swi" in 0.2s → not emitted.
//  • "swi" is followed by "swift" in 0.3s → that’s right at the debounce window; depending on timer precision, "swi" may emit, but typically the last "swift" will definitely emit after 300ms of quiet following it.

// This pattern mimics debouncing text input (e.g., search queries) to avoid firing a request on every keystroke and only act once the user pauses typing.

// Output:
Debounced: swi at 2025-11-04 08:20:50 +0000
Debounced: swift at 2025-11-04 08:20:50 +0000
```

```swift

// EXAMPLE: combineLatest

let pub1 = PassthroughSubject<Int, Never>()
let pub2 = PassthroughSubject<Int, Never>()

let otherCancellable = pub1
    .combineLatest(pub2) // publishes a tuple upon receiving output from either publisher.
    .sink { print("Result: \($0).") }


pub1.send(1) // pub1 latest at this point is 1
pub1.send(2) // pub1 latest at this point is 2
pub2.send(2) // pub2 latest at this point is 2
pub1.send(3) // pub1 latest at this point is 3
pub1.send(45) // pub1 latest at this point is 45
pub2.send(22) // pub2 latest at this point is 22

// Prints:
//    Result: (2, 2).    // pub1 latest = 2, pub2 latest = 2
//    Result: (3, 2).    // pub1 latest = 3, pub2 latest = 2
//    Result: (45, 2).   // pub1 latest = 45, pub2 latest = 2
//    Result: (45, 22).  // pub1 latest = 45, pub2 latest = 22

```

```swift

// EXAMPLE: CurrentValueSubject

let currentValueSubject = CurrentValueSubject<Int, Never>(100) // wraps a single value and publishes a new element whenever that value changes

let currentValueSubcriber = currentValueSubject
    .sink { value in
        print("Current value is \(value) at \(Date())")
    }

DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
    print("Sending new value at \(Date())")
    currentValueSubject.send(200)
}

// Output: 

Current value is 100 at 2025-11-04 08:40:35 +0000 // this gets printed because it is 'the current value' (even though it didn't change yet)
Sending new value at 2025-11-04 08:40:36 +0000
Current value is 200 at 2025-11-04 08:40:36 +0000

```

```swift

// EXAMPLE: PassthroughSubject

let passThroughSubj = PassthroughSubject<Int, Never>() // doesn't have an initial value; convenient way to adapt existing imperative code to the Combine model.

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    passThroughSubj.send(20)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
    passThroughSubj.send(40)
}

let subscriberOfPassthrough = passThroughSubj
    .sink { value in
        print("Got passthrough value: \(value) at \(Date())")
    }

// Output:

Got passthrough value: 20 at 2025-11-04 08:44:20 +0000
Got passthrough value: 40 at 2025-11-04 08:44:26 +0000
```

```swift

// EXAMPLE: PassthroughSubject vs CurrentValueSubject (Quick Guide)

• PassthroughSubject
   • Emits values to subscribers only when send(_:) is called.
   • Does not store the latest value; new subscribers won’t receive any previous value.
   • Great for event streams (taps, notifications).

• CurrentValueSubject
   • Holds and exposes a current value (.value) and immediately sends it to new subscribers.
   • Emits on send(_:) and when .value changes.
   • Great for state that always has a meaningful “current” value.

// 1) PassthroughSubject: no initial value, no replay
let passthrough = PassthroughSubject<Int, Never>()

let subA = passthrough.sink { print("A received:", $0) }
passthrough.send(1)  // A receives 1
passthrough.send(2)  // A receives 2

let subB = passthrough.sink { print("B received:", $0) }
// B receives nothing yet (no replay)
passthrough.send(3)  // A receives 3, B receives 3

// 2) CurrentValueSubject: has initial value, replays latest to new subscribers
let current = CurrentValueSubject<Int, Never>(100)

let subC = current.sink { print("C received:", $0) }
// C immediately receives 100

current.send(200)     // C receives 200
print("Current value:", current.value) // 200

let subD = current.sink { print("D received:", $0) }
// D immediately receives 200 (latest value)
current.send(300)     // C receives 300, D receives 300

When to use which
• Use PassthroughSubject for transient events with no meaningful “last value.”
• Use CurrentValueSubject for stateful data where subscribers should always see the latest value upon subscription.

```

```swift

// EXAMPLE: Publishers with limited subscriptions

let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect() // unlimited emitted values

let foodPublisher = ["meat", "orange", "milk", "honey"].publisher // limited emitted values (only the ones from the array)

let zippedSub = foodPublisher.zip(timerPublisher).sink { completion in // limited emitted values (combination/tuple of the 2 publishers) 
    print("finished emitting values with completion: \(completion)")
} receiveValue: { receivedValue in
    print("received value: \(receivedValue)")
}

// Output:
received value: ("meat", 2025-11-05 10:44:41 +0000)
received value: ("orange", 2025-11-05 10:44:42 +0000)
received value: ("milk", 2025-11-05 10:44:43 +0000)
received value: ("honey", 2025-11-05 10:44:44 +0000)
finished emitting values with completion: finished
```

```swift

// EXAMPLE: assign(to: , on:)

class MyClass {
    var myValue: Int = 0 {
        didSet {
            print("myValue was set to: \(myValue)")
        }
    }
}

let myObject = MyClass()
let publisher = (1...3).publisher
let sub = publisher.sink { value in
    myObject.myValue = value
}

// vs

let otherSub = publisher.assign(to: \.myValue, on: myObject) // easier 
// assign > Take each value emitted by the publisher and 'put it' into a property on an object

// Output is the same: 
myValue was set to: 1
myValue was set to: 2
myValue was set to: 3
```

```swift

// EXAMPLE: UITextField, UILabel + assign 

final class TextFieldViewController: UIViewController {
    let textField: UITextField = ...
    let mirroredLabel: UILabel = ...

    private let textFieldSubject = CurrentValueSubject<String, Never>("") // publisher
    private var subscriptions: Set<AnyCancellable> = []
    
    override func loadView() {
        // create the root view
        
        // add constraints
            
        // assign what is being typed in the textfield to the label
        textFieldSubject
            .compactMap { $0 } // take the non optional value of textfield.text
            .assign(to: \.text, on: mirroredLabel) // actually assigning the textfield's text to the label's text
            .store(in: &subscriptions) // store this so that it works
        
        textField.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
    }
    
    @objc func textFieldTextChanged(_ sender: UITextField) { // when editing changes, send values using the CurrentValueSubject (or just change it's value)
        textFieldSubject.send(sender.text ?? "")
        // or textFieldSubject.value = sender.text ?? ""
    }
}
```

```swift

// EXAMPLE: assign(to: ) + SwiftUI & Published

class MyModel: ObservableObject {
    @Published var lastUpdated: Date = Date()

    init() {
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .assign(to: &$lastUpdated) // no memory leak to 'capturing self'
    }
}

struct ClockView: View {
    @StateObject var clockModel = MyModel()
    
    var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter
    }
    
    var body: some View {
        Text(dateFormatter.string(from: clockModel.lastUpdated))
            .fixedSize()
            .padding(50)
    }
}
```

```swift

// EXAMPLE: .assign + strong reference cycle + memory leak
// https://developer.apple.com/documentation/combine/publisher/assign(to:on:)

class MyClass {
    var anInt: Int = 0 {
        didSet {
            print("anInt was set to: \(anInt)")
        }
    }
    
    var subject = CurrentValueSubject<Int, Never>(0)
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        subject
            .assign(to: \.anInt, on: self) // the publisher instance keeps a strong reference to self; better use .sink 
            .store(in: &subscriptions)
    }
    
    deinit {
        print("deinit called") // not called
    }
}


var myObject: MyClass? = MyClass()
myObject?.subject.send(10)
myObject = nil

// Output:
anInt was set to: 0
anInt was set to: 10
```

```swift

// EXAMPLE: .receive(on: )

let intSubject = PassthroughSubject<Int, Never>()

let subscription = intSubject
    .receive(on: DispatchQueue.main) // make sure to receive values on main thread
    .sink(receiveValue: { value in
        print("receive value \(value) on thread: \(Thread.current)")
    })

intSubject.send(1) // supposedly sending from Main thread

DispatchQueue.global().async {
  intSubject.send(2) // sending from a background thread
}

```

```swift

// EXAMPLE: .scan 

let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)

let subscription = timerPublisher
    .autoconnect()
    .scan(0) { result, _ in // basically return +1, starting from 0, ignoring the Date that the Timer publisher published
        return result + 1
    }
    .sink { valueReceived in
        print(valueReceived)
    }

// Output:
1
2
3
...


let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)

let subscription = timerPublisher
    .autoconnect()
    .scan(1) { accumulatingResult, publishedDate in // takes into consideration the published date value from the Timer publisher
        let calendar = Calendar.current
        let seconds = calendar.component(.second, from: publishedDate)
        
        if seconds.isMultiple(of: 2) {
            return accumulatingResult * 2
        } else {
            return accumulatingResult * 3
        }
    }
    .sink { valueReceived in
        print(valueReceived)
    }

// Output:
3
6
18
36
108
...
```

```swift

// EXAMPLE: .removeDuplicates


let publisherWithDuplicates = ["A", "B", "C", "C", "D", "D", "E", "F", "G", "H", "H"].publisher
let subscriberWithoutDuplicates = publisherWithDuplicates
    .removeDuplicates() // removes duplicate values if they come one after the other (come in sequence) ; can be useful in scenarios when user taps a button multiple times and we don't want to perform some request multiple times for the same input
    .sink { receivedValue in
        print(receivedValue)
    }

// Output:
A
B
C
D
E
F
G
H

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
- [Processing URL session data task results with Combine](https://developer.apple.com/documentation/foundation/processing-url-session-data-task-results-with-combine)
- [Karin Prater's Combine Framework Tutorial](https://www.youtube.com/playlist?list=PLWHegwAgjOkoIMgZ7QF_SHUtEB_rWXtH0)



