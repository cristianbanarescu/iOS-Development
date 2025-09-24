import UIKit
import Combine

// https://medium.com/@amitaswal87/combine-in-swift-third-part-types-of-publishers-and-subscribers-40175524b601

let publisher = Just("hey") // A publisher that emits an output to each subscriber just once, and then finishes.

//let subscriber = publisher.sink { valueReceived in
//    print(valueReceived)
//}

let timerPublisher = Timer.publish(every: 1.0, on: .main, in: .common)
//let cancellableTimer = timerPublisher.autoconnect().sink { date in // cancellableTimer is actually subscribing to the Publisher by using .sink
//    print(date)
//}

@MainActor
class MyClass {
    private var cancellables: Set<AnyCancellable> = []
    private var timerSubscription2: AnyCancellable? = nil
    
    func postTimerDate() {
        timerPublisher.autoconnect().sink { date in
            print(date) // .sink returns a 'subscription' that needs to be kept alive so that you receive events/values from publishers
        }.store(in: &cancellables) // need to store the subscription to the publisher. if you don't store the subscription, you won't get values from it; Deallocation of the subscription (result from calling .sink on a publisher) will tear down the subscription stream.
    }
    
    func postTimerDateUsingStoredSubscription() {
        timerSubscription2 = timerPublisher.autoconnect().sink(receiveValue: { date in
            print(date)
        })
    }
    
     func cancelTimerSubscription2() {
        timerSubscription2?.cancel()
        
//        print("I'm done with the timer subscription!")
    }
    
    func setTimerSubscription2ToNil() {
        timerSubscription2 = nil // this will cancel subscriptions and you won't print out any values
    }
}

let myClass = MyClass()
//myClass.postTimerDate()
//myClass.postTimerDateUsingStoredSubscription()

Task { @MainActor in
//    try? await Task.sleep(for: .seconds(3))
//    myClass.setTimerSubscription2ToNil()
    
    try? await Task.sleep(for: .seconds(10))
    
    myClass.cancelTimerSubscription2()
}

let publisherArray = [1, 2, 3, 4, 5, 6].publisher

//let subscription = publisherArray
//    .map { "Hello, World! \($0)" } // transform each value emitted by the publisher
//    .sink { valueReceived in
//        print(valueReceived)
//    }

let stringPublisher = ["1", "2", "A", "B", "3"].publisher

enum StringError: Error {
    case cannotConvertToInt
}

let publisherWithPossibleFailure = stringPublisher
    .tryMap { emittedString in // use tryMap when you want to throw errors inside
        let intValue = Int(emittedString)
        
        if let intValue {
            return intValue
        } else {
            throw StringError.cannotConvertToInt
        }
    }

let stringSubscription = publisherWithPossibleFailure
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

let firstPublisher = [1, 2, 3, 4, 5].publisher
let secondPublisher = Just(99)

let mergedPublisher = Publishers.Merge(firstPublisher, secondPublisher)

print("will print a merge of 2 publishers:")

let subscription = mergedPublisher.sink { value in
    print(value)
}

print("will print a subscriptionWithCompactMap:")

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

let filterPublisher = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].publisher

let subscriptionWithEvenNumbers = filterPublisher
    .filter { $0.isMultiple(of: 2) } // filter data emitted by the publisher
    .sink { value in
        print("received even number: \(value)")
    }

struct SimpleError: Error {}
let numbers = [5, 4, 3, 2, 1, 0, 9, 8, 7, 6]
let cancellable = numbers.publisher
    .tryMap {
        guard $0 != 0 else { throw SimpleError() }
        return $0
    }
    .catch({ (error) in
        print(error.localizedDescription)
        return Just(-1)
    })
    .sink { print("\($0)") } // stops when reaching 0
    

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

// there's also Publishers.Zip4

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
    .replaceError(with: -100)
    .sink { value in
        print(value)
    }

print("retrying...")

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
//        print(error.localizedDescription)
        return Just(-1) // this is 'delivered' only after retrying for 3 times
    }
    .sink { value in
        print(value)
    }

// See more about operators here: https://developer.apple.com/documentation/combine/just-publisher-operators

/*
 TODO: send, subjects, debounce, combineLatest
 */
