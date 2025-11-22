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

//DispatchQueue.global().sync {
//    print("This runs on a background thread, but blocks the caller - block and wait")
//}
//print("This runs AFTER the sync block")
//
//print("------------------------")

//DispatchQueue.global().async {
//    print("This runs in the background and doesn't block the thread - fire and forget")
//}
//print("This runs IMMEDIATELY, doesn't wait for the block")
//
////print("------------------------")
//
//let serialQueue = DispatchQueue(label: "serial")
//serialQueue.sync {
//    print("This will run but deadlock won't")
//    
//    serialQueue.sync { // Avoid calling sync on the same queue you’re currently running on, especially the main queue — it will cause a deadlock.
//        print("Deadlock")
//    }
//}

//let serial = DispatchQueue(label: "first")
//
//serial.async {
//    print("1")
//
//    serial.sync {
//        print("2")
//    }
//
//    print("3")
//}

/*
 
 The async block is dispatched to the serial queue, and "1" is printed.
 Inside the async block, there is a sync block dispatched to the same serial queue.
 The sync block waits for the async block to complete before executing.
 However, the async block cannot complete because it is waiting for the sync block to complete.

 */
//
//for i in 1...40 {
//    let newQueue = DispatchQueue(label: "MyNewQueue")
//    newQueue.async {
//        print("Async task")
//    }
//    
//    print("On Main thread")
//    
//    newQueue.sync {
//        print("Sync task")
//    }
//    
//    print("______________")
//}

//Emoji -> Cmd + Ctrl + Space

//let newQueue = DispatchQueue(label: "MyNewQueue")
//var value = 0
//
//extension Thread {
//    var threadName: String {
//        if let currentOperationQueue = OperationQueue.current?.name {
//            return "OperationQueue: \(currentOperationQueue)"
//        } else if let underlyingDispatchQueue = OperationQueue.current?.underlyingQueue?.label {
//            return "DispatchQueue: \(underlyingDispatchQueue)"
//        } else {
//            let name = __dispatch_queue_get_label(nil)
//            return String(cString: name, encoding: .utf8) ?? Thread.current.description
//        }
//    }
//}
//
//print(String(repeating: "-", count: 20), "Experiment #1", String(repeating: "-", count: 20))
//
//
////This will run on MyNewQueue
//newQueue.async {
//    for i in 0...3 {
//        value = i
//        
//        print("Inside first <\(Thread.current.threadName)> \(value) 😜")
//    }
//}
//
//print("I am here on main thread - after first async")
//
//newQueue.async {
//    for i in 4...6 {
//        value = i
//        
//        print("Inside second <\(Thread.current.threadName)> \(value) 😜")
//    }
//}
//
//print("I am here on main thread - after second async")
//
////This will execute on main thread as it is happening synchronously on main thread
//newQueue.sync {
//    for i in 7...9 {
//        value = i
//        
//        print("Inside third <\(Thread.current.threadName)> \(value) 😍")
//    }
//}
//
//print("I am here on main thread - after third sync")
//
////This will run on MyNewQueue
//newQueue.async {
//    value = 10
//    print("Inside forth <\(Thread.current.threadName)> \(value) 🤣")
//}
//
//print("I am here on main thread - after forth async")
//
//DispatchQueue.main.async {
//    print("Async Dispatch main <\(Thread.current.threadName)>")
//}

//class DateFormatterCache {
//  private var formatters = [String: DateFormatter]()
//  private let queue = DispatchQueue(label: "DateFormatterCache")
//
//  func formatter(using format: String) -> DateFormatter {
////      print(queue)
//    return queue.sync { [unowned self] in
//      if let formatter = self.formatters[format] {
//        return formatter
//      }
//
//      let formatter = DateFormatter()
//      formatter.locale = Locale(identifier: "en_US_POSIX")
//      formatter.dateFormat = format
//      self.formatters[format] = formatter
//
//        print(formatters)
//      return formatter
//    }
//  }
//}
//
//let cache1 = DateFormatterCache()
//let cache2 = DateFormatterCache()
//
//DispatchQueue.global().async {
//    print("1, Thread.current: \(Thread.current)")
//    cache1.formatter(using: "otherformat")
//}
//
//DispatchQueue.global(qos: .userInitiated).async {
//    print("2, Thread.current: \(Thread.current)")
//    cache1.formatter(using: "otherformat")
//}
//
