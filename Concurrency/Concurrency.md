# iOS multithreading and concurrent programming

Concurrent programming - executing multiple tasks simultaneously, allowing for more efficient multitasking and improved performance.
In iOS you take care of this by switching between threads based on complexity and duration of operations.
You can use:
    - DispatchQueue
    - OperationQueue
    - Combine
    - Async await

## GCD

Grand Central Dispatch (GCD) provides queues for scheduling work.
[DispatchQueue](https://developer.apple.com/documentation/dispatch/dispatchqueue) manages the execution of tasks in a FIFO order.

- DispatchGroup
- DispatchSemaphore
- DispatchWorkItem
- Dispatch Barrier
- DispatchSource (How To Handle Files and Folders)

## Swift Concurrency

## Serial vs concurrent queues

- affects on how many tasks can be executed at the same time

### Serial queues

- execute tasks one after the other > FIFO order
- guarantees ordering across tasks submitted to the same queue (the order of tasks to complete is guaranteed)
- for a serial queue it doesn't matter how you call tasks (async vs sync), they will execute one by one.
- e.g DispatchQueue.main is a serial queue - you get this by default
- Use a serial queue to protect shared mutable state and guarantee ordering.
- Predictable execution order
- Prevents race conditions

### Concurrent queues

- Can execute multiple tasks in parallel (order of start/completion is not guaranteed).
- still FIFO in terms of when tasks become eligible to run, but tasks may overlap and order of how tasks finish execution is not guaranteed. They still start one after the other (FIFO order) but the order in which they finish is not guaranteed.
- Use a concurrent queue to increase throughput for independent tasks.
- Faster but unpredictable order of how tasks finish
- Concurrent queues (background ones) by default depending on their proirities -> Quality-of-Service Class

## Sync vs async

- affects on thread blocking: sync blocks the thread until a task finishes; async DOES NOT > returns control to code immediately and executes other code

### Sync

- Calling code synchronously on a serial queue (`queue.sync { }`), it blocks the thread until the code finishes and then lets another code execute. 
- Submits work and waits for it to finish (blocks the calling thread).
- DispatchQueue.sync doesn't break the current flow of execution
- Useful when you need a result before continuing.
- Be careful: calling sync on the same queue you’re currently executing on can deadlock: a situation where two or more tasks each wait for the other to release a resource or complete, causing all of them to wait forever and the system to make no progress.
- Use sync when you need results before continuing, and avoid calling sync on the same queue you’re currently on.
- "Block and wait"

### Async

- Calling code async on a serial queue doesn't block the thread but tasks from the queue are still executed one by one.
- Submits work and returns immediately (does not block the caller) without waiting for the task to finish
- Useful for offloading work and keeping the caller responsive.
- Execution may begin before or after subsequent code on the caller, depending on scheduling.
- Prefer async to keep UIs responsive and avoid blocking.
- "Fire and forget"
- DispatchQueue.async allows the current flow to continue. The block executes at a later time.
- Async tasks may complete in a different order than how they started because of their complexity and duration
- When you use `async` on a DispatchQueue, you ask the queue to execute the work from the closure and you 'tell' the queue that you don't want that worked to be performed right now necessarily and you don't want to wait for it to finish; You schedule some work to be done without blocking whatever is ongoing already.

## Code samples


```swift

// MARK: - serial queue + calling code with sync
let serialQueue = DispatchQueue(label: "serial") // DispatchQueue(label) init creates a serial queue; provide a label for easier debugging and investigation

serialQueue.sync { // block the thread here and execute this task
    print("1 - start")
    print("1 - finish")
}

print("between - start") // then execute these 2, because it is a serial queue and tasks execute one after the other
print("between - finish")

serialQueue.sync { // block the thread again here and execute this task
    print("2 - start")
    print("2 - finish")
}

// Output: (everything is executed one by one, one after the other)
1 - start
1 - finish
between - start
between - finish
2 - start
2 - finish
```

```swift
// MARK: - serial queue + calling code with async (note: this is in the playground and code in playground runs by default on Main Thread)

let serialQueue = DispatchQueue(label: "serial") // DispatchQueue(label) init creates a serial queue

serialQueue.async { // async does not block the caller, but it also doesn’t guarantee the main thread will print first. It only guarantees that tasks on the same serial queue run in order relative to each other. So the 2 async prints from below will definitely NOT run before these 2 
    print("1 - start")
    print("1 - finish")
}

print("between - start")
print("between - finish")

serialQueue.async {
    print("2 - start")
    print("2 - finish")
}
// Output:
1 - start
between - start
between - finish
1 - finish
2 - start
2 - finish

// If the serial queue is actually the Main queue (associated with the Main Thread), the output is this:
between - start
between - finish
1 - start
1 - finish
2 - start
2 - finish
```

```swift
// MARK: - Concurrent queue + sync
let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent) // DispatchQueue(label) init creates a serial queue

concurrentQueue.sync { // blocks the thread here and lets these 2 prints execute
    print("1 - start")
    print("1 - finish")
}

print("between - start")
print("between - finish")

concurrentQueue.sync {
    print("2 - start")
    print("2 - finish")
}
// Output:
1 - start
1 - finish
between - start
between - finish
2 - start
2 - finish
```

```swift
// MARK: - Concurrent queue + async 
let concurrentQueue = DispatchQueue(label: "concurrent", attributes: .concurrent) // DispatchQueue(label) init creates a serial queue usually

concurrentQueue.async { // does NOT block the thread here and lets other code execute
    print("1 - start")
    print("1 - finish")
}

print("between - start")
print("between - finish")

concurrentQueue.async {
    print("2 - start")
    print("2 - finish")
}
// Output:
1 - start
between - start
1 - finish
between - finish
2 - start
2 - finish
// order of how task finish is undefined/it depends but still the first async block will execute before the 2nd async block because tasks still start FIFO 
```

```swift
// MARK: - Concurrent queue + sync
DispatchQueue.global().sync {
    print("This runs on a background thread, but blocks the caller - block and wait")
}
print("This runs AFTER the sync block")
// Output:
This runs on a background thread, but blocks the caller - block and wait
This runs AFTER the sync block
```

```swift
// MARK: - Concurrent queue + async

DispatchQueue.global().async {
    print("This runs in the background and doesn't block the thread - fire and forget")
}
print("This runs IMMEDIATELY, doesn't wait for the block")
// Output:
This runs IMMEDIATELY, doesn't wait for the block
This runs in the background and doesn't block the thread - fire and forget
```

```swift
// MARK: - Dispatch back to the main queue for UI updates
DispatchQueue.global(qos: .userInitiated).async {
    let data = heavyWork()
    DispatchQueue.main.async {
        updateUI(with: data)
    }
}
```

```swift
// MARK: - Barrier on a concurrent queue to serialize a write among reads
let rwQueue = DispatchQueue(label: "com.example.rw", attributes: .concurrent)

func read(_ block: @escaping () -> Void) {
    rwQueue.async { block() } // multiple reads can run in parallel
}

func write(_ block: @escaping () -> Void) {
    rwQueue.async(flags: .barrier) { block() } // exclusive write
}
```

```swift
// MARK: - Avoid deadlock
let q = DispatchQueue(label: "com.example.serial")

q.async {
    // Don’t do q.sync { ... } here — it would deadlock.
    doWork()
}
```

```swift
// MARK: - Deadlock 
let serialQueue = DispatchQueue(label: "serial")
serialQueue.sync {
    print("This will run but deadlock won't")
    
    serialQueue.sync { // Avoid calling sync on the same queue you’re currently running on, especially the main queue — it will cause a deadlock.
        print("Deadlock")
    }
}
```

```swift
// MARK: - Another deadlock
let serial = DispatchQueue(label: "first")

serial.async { //  The async block is dispatched to the serial queue, and "1" is printed.
    print("1")

    serial.sync { //  Inside the async block, there is a sync block dispatched to the same serial queue.
    //  The sync block waits for the async block to complete before executing.
    //  However, the async block cannot complete because it is waiting for the sync block to complete.
        print("2")
    }

    print("3")
}
// Output:
1

```

## Scenarios

Q: 'You have three APIs — they can be called in any order; maybe 1 & 2 execute and then wait for 3. Or any other combination'
A: 
- nested blocks
- DispatchQueue + completion
- OperationQueue (helps to add dependencies between operations)
```swift
    let queue = OperationQueue()
    let op1 = BlockOperation {
        print("stuff")
    }
    let op2 = BlockOperation {
        print("stuff 2")
    }
    let op3 = BlockOperation {
        print("stuff 3")
    }
    op2.addDependency(op1)
    op3.addDependency(op2)
    queue.addOperations([op1, op2, op3], waitUntilFinished: false)
```
- async await
```swift
func fetchAll() async {
    let r1 = await api1()
    let r2 = await api2()
    let r3 = await api3()
}
```
- DispatchGroup (api1 and api2 run in parallel and then api3 gets excuted)
```swift
let group = DispatchGroup()

group.enter()
api1 { _ in group.leave() }

group.enter() 
api2 { _ in group.leave() }

group.notify(queue: .main) {
    api3 { _ in }
}
```
- async await (api1 and api2 run in parallel and then api3 gets excuted)
```swift
Task {
    async let r1 = api1()
    async let r2 = api2()
    let _ = await (r1, r2)
    await api3()
}
```
- Combine (api1 and api2 run in parallel and then api3 gets excuted)
```swift
Publishers.Zip(api1Publisher, api2Publisher)
    .sink { _ in api3 { _ in } }
```

## Main Thread vs. Background Thread (Global Thread)


## Other

- AsyncAfter
- (NS)Operation and (NS)OperationQueue
- Deadlock
- Main Thread Checker
- Async / Await / Actor Is iOS13+

## Credits & Useful links

- [Apple - DispatchQueue class](https://developer.apple.com/documentation/dispatch/dispatchqueue)
- https://betterprogramming.pub/the-complete-guide-to-concurrency-and-multithreading-in-ios-59c5606795ca#b3d8
- https://medium.com/geekculture/threads-in-ios-gcd-nsoperation-part-1-64e460c0bdea
- https://khanumair-9430.medium.com/gcd-dispatchworkitem-swift-cancelling-a-task-in-dispatch-68da958c5b20
- [Dispatch Group vs Operation — iOS Swift](https://medium.com/@basnurevinod/dispatch-group-vs-operation-ios-swift-3a62540e6b1b#:~:text=With%20GCD%20Queues%20Dispatch%20Queues,as%20we%20call%20in%20Operation)
- https://medium.com/@sizonov.9595/difference-between-sync-and-async-in-serial-and-concurrent-queues-70bdf57bb6ab
- https://blog.devgenius.io/gcd-learning-series-day-3-sync-vs-async-in-dispatchqueue-70adcb2f2909
- [Sean Allen Concurrency & Threading](https://www.youtube.com/watch?v=iTcq6L-PaDQ&t=3s)
- https://dev.to/bibinjaimon/dispatchqueue-in-swift-3198
- https://medium.com/@mohitdubey_83162/interview-dispatchqueues-sync-vs-async-explained-f425635a1744
- https://medium.com/@mohitdubey_83162/interview-concurrent-vs-serial-dispatch-queues-in-swift-d076c8af9423
- https://www.donnywals.com/dispatching-async-or-sync-the-differences-explained/
- [Swift Concurrency Interview Cheatsheet](https://medium.com/@aayushi9555/swift-concurrency-interview-cheatsheet-16d30e258988)