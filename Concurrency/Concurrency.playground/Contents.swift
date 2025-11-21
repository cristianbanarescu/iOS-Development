import UIKit

//let serialQueue = DispatchQueue(label: "serial") // DispatchQueue(label) init creates a serial queue

//serialQueue.async {
//    print("1 - start")
//    print("1 - finish")
//}
//
//print("between - start")
//print("between - finish")
//
//serialQueue.async {
//    print("2 - start")
//    print("2 - finish")
//}

//let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent) // DispatchQueue(label) init creates a serial queue
//
//concurrentQueue.sync { // blocks the thread here and lets these 2 prints execute
//    print("1 - start")
//    print("1 - finish")
//}
//
//print("between - start")
//print("between - finish")
//
//concurrentQueue.sync {
//    print("2 - start")
//    print("2 - finish")
//}

//let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent) // DispatchQueue(label) init creates a serial queue
//
//concurrentQueue.async { // does NOT block the thread here and lets other code execute
//    print("1 - start")
//    print("1 - finish")
//}
//
//print("between - start")
//print("between - finish")
//
//concurrentQueue.async {
//    print("2 - start")
//    print("2 - finish")
//}

let main = DispatchQueue(label: "123")

main.sync {
    print("deadlock")
}
