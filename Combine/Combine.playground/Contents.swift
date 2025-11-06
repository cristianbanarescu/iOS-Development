import UIKit
@preconcurrency import Combine
import PlaygroundSupport
import SwiftUI

//// https://medium.com/@amitaswal87/combine-in-swift-third-part-types-of-publishers-and-subscribers-40175524b601
//
//let publisher = Just("hey") // A publisher that emits an output to each subscriber just once, and then finishes.
//
//let subscriber = publisher.sink { valueReceived in
//    print(valueReceived)
//}
//
//let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
//let cancellableTimer = timerPublisher.autoconnect().sink { date in // cancellableTimer is actually subscribing to the Publisher by using .sink
//    print(date)
//}
//
//@MainActor
//class MyClass {
//    private var cancellables: Set<AnyCancellable> = []
//    private var timerSubscription2: AnyCancellable? = nil
//    
//    func postTimerDate() {
//        timerPublisher.autoconnect().sink { date in
//            print(date) // .sink returns a 'subscription' that needs to be kept alive so that you receive events/values from publishers
//        }.store(in: &cancellables) // need to store the subscription to the publisher. if you don't store the subscription, you won't get values from it; Deallocation of the subscription (result from calling .sink on a publisher) will tear down the subscription stream.
//    }
//    
//    func postTimerDateUsingStoredSubscription() {
//        timerSubscription2 = timerPublisher.autoconnect().sink(receiveValue: { date in
//            print(date)
//        })
//    }
//    
//     func cancelTimerSubscription2() {
//        timerSubscription2?.cancel()
//    }
//    
//    func setTimerSubscription2ToNil() {
//        timerSubscription2 = nil // this will cancel subscriptions and you won't print out any values
//    }
//}
//
//let myClass = MyClass()
//myClass.postTimerDate()
//myClass.postTimerDateUsingStoredSubscription()

//Task { @MainActor in
////    try? await Task.sleep(for: .seconds(3))
////    myClass.setTimerSubscription2ToNil()
//    
//    try? await Task.sleep(for: .seconds(10))
//    
//    myClass.cancelTimerSubscription2()
//}

let publisherArray = [1, 2, 3, 4, 5, 6].publisher

//let subscription = publisherArray
//    .map { "Hello, World! \($0)" } // transform each value emitted by the publisher
//    .sink { valueReceived in
//        print(valueReceived)
//    }

let stringPublisher = ["1", "2", "A", "B", "3"].publisher
//
////let stringSub = stringPublisher.sink { receivedValue in
////    print(receivedValue)
////}
//
enum StringError: Error, CustomStringConvertible {
    case cannotConvertToInt
    
    var description: String {
        switch self {
        case .cannotConvertToInt:
            "Conversion to int is impossible"
        }
    }
}
//
let publisherWithPossibleFailure = stringPublisher
    .tryMap { emittedString in // use tryMap when you want to throw errors inside
        let intValue = Int(emittedString)
        
        if let intValue {
            return intValue
        } else {
            throw StringError.cannotConvertToInt
        }
    }
//
//let subscriptionForPossibleStringFailure = publisherWithPossibleFailure.sink { completion in
//    switch completion {
//    case .finished:
//        print("Done receiving elements")
//    case .failure(let error as StringError):
//        print(error.description)
//    case .failure(_):
//        print("general failure")
//    }
//} receiveValue: { receivedValue in
//    print(receivedValue)
//}


//let stringSubscription = publisherWithPossibleFailure
//    .sink { completion in
//        switch completion {
//        case .finished:
//            print("finished emitting values")
//        case .failure(let error):
//            print(error.localizedDescription)
//        }
//    } receiveValue: { receivedValue in
//        print(receivedValue)
//    }

//struct MyGenericError: Error { var wrappedError: Error }
//
//let mapErrorSubscription = publisherWithPossibleFailure
//    .mapError { error in
//        return MyGenericError(wrappedError: error) // I receive a StringError and 'turn it' (map) into a MyGenericError
//    }
//    .sink { completion in
//        switch completion {
//        case .finished:
//            print("finished emitting values")
//        case .failure(let error):
//            print(error.localizedDescription)
//        }
//    } receiveValue: { receivedValue in
//        print(receivedValue)
//    }

//let firstPublisher = [1, 2, 3, 4, 5].publisher
//let secondPublisher = Just(99)
//let mergedPublisher = Publishers.Merge(firstPublisher, secondPublisher)
//
//print("will print a merge of 2 publishers:")
//
//let subscription = mergedPublisher.sink { value in
//    print(value)
//}
//
//print("will print a subscriptionWithCompactMap:")

//let subscriptionWithCompactMap = stringPublisher // ["1", "2", "A", "B", "3"].publisher
//    .compactMap { emittedString in // use compactMap when you want NON-nil values only
//        let intValue = Int(emittedString)
//        
//        if let intValue {
//            return intValue
//        } else {
//            return nil
//        }
//    }
//    .sink { value in
//        print(value)
//    }

//let filterPublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher
//
//let subscriptionWithEvenNumbers = filterPublisher
//    .filter { $0.isMultiple(of: 2) } // filter data emitted by the publisher
//    .sink { value in
//        print("received even number: \(value)")
//    }

//struct SimpleError: Error {}
//let numbers = [5, 4, 3, 2, 1, 0, 9, 8, 7, 6]
//let cancellable = numbers.publisher
//    .tryMap {
//        guard $0 != 0 else { throw SimpleError() }
//        return $0
//    }
//    .catch({ (error) in
//        print(error.localizedDescription)
//        return Just(-1)
//    })
//    .sink { print("\($0)") } // stops when reaching 0
    

//let publisherZip1 = [1, 2, 3].publisher
//let publisherZip2 = ["a", "b", "c"].publisher
//
//let subscriptionZip = Publishers.Zip(publisherZip1, publisherZip2)
//    .sink { value in
//        print(value) // (1, a), (2, b), (3, c)
//    }
//
//let publisherZip3 = [1.3, 23.12, 123.43].publisher
//
//let subscriptionZip3 = Publishers.Zip3(publisherZip1, publisherZip2, publisherZip3)
//    .sink { value in
//        print(value) // (1, "a", 1.3) (2, "b", 23.12) (3, "c", 123.43)
//    }

// there's also Publishers.Zip4

//let publisherForReplaceError = ["1", "2", "A", "B", "3"].publisher
//
//let subscriptionForReplaceError = publisherForReplaceError
//    .tryMap { emittedString in // use tryMap when you want to throw errors inside
//        let intValue = Int(emittedString)
//        
//        if let intValue {
//            return intValue
//        } else {
//            throw StringError.cannotConvertToInt
//        }
//    }
//    .replaceError(with: -100)
//    .sink { value in
//        print(value)
//    }

//print("retrying...")
//
//let somePublisher = ["1", "2", "A", "B", "3"].publisher
//let subscriptionForReplaceError2 = somePublisher
//    .tryMap { emittedString in // use tryMap when you want to throw errors inside
//        let intValue = Int(emittedString)
//        
//        if let intValue {
//            return intValue
//        } else {
//            throw StringError.cannotConvertToInt
//        }
//    }
//    .retry(3)
//    .catch { error in
////        print(error.localizedDescription)
//        return Just(-1) // this is 'delivered' only after retrying for 3 times
//    }
//    .sink { value in
//        print(value)
//    }

// See more about operators here: https://developer.apple.com/documentation/combine/just-publisher-operators


//let bounces:[(Int,TimeInterval)] = [
//    (0, 0),
//    (1, 0.25),  // 0.25s interval since last index
//    (2, 1),     // 0.75s interval since last index
//    (3, 1.25),  // 0.25s interval since last index
//    (4, 1.5),   // 0.25s interval since last index
//    (5, 2)      // 0.5s interval since last index
//]
//
//
//let subject = PassthroughSubject<Int, Never>()
//let cancellable2 = subject
//    .debounce(for: .seconds(0.5), scheduler: RunLoop.main) // Publishes elements only after a specified time interval elapses between events.
//    .sink { index in
//        print ("Received index \(index) at \(Date())")
//    }
//
//
//for bounce in bounces {
//    DispatchQueue.main.asyncAfter(deadline: .now() + bounce.1) {
//        subject.send(bounce.0) // send a value to the subcriber
//    }
//}

//let textChanges = PassthroughSubject<String, Never>()
//let cancellable = textChanges
//    .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
//    .sink { value in
//        print("Debounced: \(value) at \(Date())")
//    }
//
//// Simulate quick typing
//Task { @MainActor in
//    textChanges.send("s")
//    
//    try? await Task.sleep(for: .seconds(0.1))
//    textChanges.send("sw")
//    
//    try? await Task.sleep(for: .seconds(0.2))
//    textChanges.send("swi") // this one emits
//    
//    try? await Task.sleep(for: .seconds(0.3))
//    textChanges.send("swift") // this one emits
//}

//let pub1 = PassthroughSubject<Int, Never>()
//let pub2 = PassthroughSubject<Int, Never>()
//
//let otherCancellable = pub1
//    .combineLatest(pub2) // publishes a tuple upon receiving output from either publisher.
//    .sink { print("Result: \($0).") }
//
//
//pub1.send(1)
//pub1.send(2) // pub1 latest at this point is 2
//pub2.send(2) // pub2 latest at this point is 2
//pub1.send(3) // pub1 latest at this point is 3
//pub1.send(45) // pub1 latest at this point is 45
//pub2.send(22) // pub2 latest at this point is 22
//
//// Prints:
////    Result: (2, 2).    // pub1 latest = 2, pub2 latest = 2
////    Result: (3, 2).    // pub1 latest = 3, pub2 latest = 2
////    Result: (45, 2).   // pub1 latest = 45, pub2 latest = 2
////    Result: (45, 22).  // pub1 latest = 45, pub2 latest = 22

//let currentValueSubject = CurrentValueSubject<Int, Never>(100) // wraps a single value and publishes a new element whenever that value changes
//
//let currentValueSubcriber = currentValueSubject
//    .sink { value in
//        print("Current value is \(value) at \(Date())")
//    }
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//    print("Sending new value at \(Date())")
//    currentValueSubject.send(200)
//}


//let passThroughSubj = PassthroughSubject<Int, Never>() // doesn't have an initial value; convenient way to adapt existing imperative code to the Combine model.
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//    passThroughSubj.send(20)
//}
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
//    passThroughSubj.send(40)
//}
//
//let subscriberOfPassthrough = passThroughSubj
//    .sink { value in
//        print("Got passthrough value: \(value) at \(Date())")
//    }

// https://developer.apple.com/documentation/combine/subject
// Subject = A publisher that exposes a method (send) for outside callers to publish elements.
// A subject is a publisher that you can use to ”inject” values into a stream, by calling its send(_:) method. This can be useful for adapting existing imperative code to the Combine model.

// MARK: - PassthroughSubject vs CurrentValueSubject

//// 1) PassthroughSubject: no initial value, no replay
//let passthrough = PassthroughSubject<Int, Never>()
//
//let subA = passthrough.sink { print("A received:", $0) }
//passthrough.send(1)  // A receives 1
//passthrough.send(2)  // A receives 2
//
//let subB = passthrough.sink { print("B received:", $0) }
//// B receives nothing yet (no replay)
//passthrough.send(3)  // A receives 3, B receives 3
//
//// 2) CurrentValueSubject: has initial value, replays latest to new subscribers
//let current = CurrentValueSubject<Int, Never>(100)
//
//let subC = current.sink { print("C received:", $0) }
//// C immediately receives 100
//
//current.send(200)     // C receives 200
//print("Current value:", current.value) // 200
//
//let subD = current.sink { print("D received:", $0) }
//// D immediately receives 200 (latest value)
//current.send(300)     // C receives 300, D receives 300

// MARK: - Publishers with limited subscriptions

//let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect() // unlimited emitted values
//
//let foodPublisher = ["meat", "orange", "milk", "honey"].publisher // limited emitted values (only the ones from the array)
//
//let zippedSub = foodPublisher.zip(timerPublisher).sink { completion in // limited emitted values (combination/tuple of the 2 publishers)
//    print("finished emitting values with completion: \(completion)")
//} receiveValue: { receivedValue in
//    print("received value: \(receivedValue)")
//}

//class MyClass {
//    var myValue: Int = 0 {
//        didSet {
//            print("myValue was set to: \(myValue)")
//        }
//    }
//}
//
//let myObject = MyClass()
//let publisher = (1...3).publisher
//let sub = publisher.sink { value in
//    myObject.myValue = value
//}
//
//// vs
//
//let otherSub = publisher.assign(to: \.myValue, on: myObject)

// MARK: - UIViewController textfield + assign(to: ,on: )

//final class TextFieldViewController: UIViewController {
//    let textField: UITextField = {
//        let tf = UITextField(frame: .zero)
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.placeholder = "Type here"
//        return tf
//    }()
//    let mirroredLabel: UILabel = {
//        let lbl = UILabel(frame: .zero)
//        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.textColor = .label
//        lbl.numberOfLines = 0
//        lbl.textAlignment = .center
//        return lbl
//    }()
//
//    private let textFieldSubject = CurrentValueSubject<String, Never>("") // publisher
//    private var subscriptions: Set<AnyCancellable> = []
//    
//    override func loadView() {
//        let root = UIView()
//        root.backgroundColor = .systemBackground
//        root.addSubview(textField)
//        root.addSubview(mirroredLabel)
//        
//        NSLayoutConstraint.activate([
//            textField.centerXAnchor.constraint(equalTo: root.centerXAnchor),
//            textField.topAnchor.constraint(equalTo: root.safeAreaLayoutGuide.topAnchor, constant: 20),
//            textField.widthAnchor.constraint(equalTo: root.widthAnchor, multiplier: 0.7),
//            mirroredLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
//            mirroredLabel.centerXAnchor.constraint(equalTo: root.centerXAnchor),
//            mirroredLabel.widthAnchor.constraint(equalTo: root.widthAnchor, multiplier: 0.8)
//        ])
//                
//        // assign what is being typed in the textfield to the label
//        textFieldSubject
//            .compactMap { $0 } // take the non optional value of textfield.text
//            .assign(to: \.text, on: mirroredLabel) // actually assigning the textfield's text to the label's text
//            .store(in: &subscriptions) // store this so that it works
//        
//        textField.addTarget(self, action: #selector(textFieldTextChanged), for: .editingChanged)
//        
//        self.view = root
//    }
//    
//    @objc func textFieldTextChanged(_ sender: UITextField) {
//        textFieldSubject.send(sender.text ?? "")
//        // or textFieldSubject.value = sender.text ?? ""
//    }
//}
//
//PlaygroundPage.current.liveView = TextFieldViewController()

//
//class MyModel: ObservableObject {
//    @Published var lastUpdated: Date = Date()
//
//    init() {
//         Timer.publish(every: 1.0, on: .main, in: .common)
//             .autoconnect()
//             .assign(to: &$lastUpdated)
//    }
//}
//
//struct ClockView: View {
//    @StateObject var clockModel = MyModel()
//    
//    var dateFormatter: DateFormatter {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm:ss"
//        return dateFormatter
//    }
//    
//    var body: some View {
//        Text(dateFormatter.string(from: clockModel.lastUpdated))
//            .fixedSize()
//            .padding(50)
//    }
//}
//
//PlaygroundPage.current.setLiveView(ClockView())

PlaygroundPage.current.needsIndefiniteExecution = true




