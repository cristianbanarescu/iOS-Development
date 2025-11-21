# Useful info about iOS multithreading

## GCD

Grand Central Dispatch (GCD) provides queues for scheduling work.

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
- guarantees ordering across tasks submitted to the same queue
- for a serial queue it doesn't matter how you call tasks (async vs sync), they will execute one by one.
- e.g DispatchQueue.main is a serial queue
- Use a serial queue to protect shared mutable state and guarantee ordering.

### Concurrent queues

- can execute multiple tasks in parallel (order of start/completion is not guaranteed).
- still FIFO in terms of when tasks become eligible to run, but tasks may overlap.
- Use a concurrent queue to increase throughput for independent tasks.

## Sync vs async

- affects on thread blocking: sync blocks the thread until a task finishes; async DOES NOT > returns control to code immediately and executes other code

### Sync

- Calling code synchronously on a serial queue (`queue.sync { }`), it blocks the thread until the code finishes and then lets another code execute. 
- Submits work and waits for it to finish (blocks the calling thread).
- Useful when you need a result before continuing.
- Be careful: calling sync on the same queue you’re currently executing on can deadlock: a situation where two or more tasks each wait for the other to release a resource or complete, causing all of them to wait forever and the system to make no progress.
- Use sync when you need results before continuing, and avoid calling sync on the same queue you’re currently on.

### Async

- Calling code async on a serial queue doesn't block the thread but tasks from the queue are still executed one by one.
- Submits work and returns immediately (does not block the caller).
- Useful for offloading work and keeping the caller responsive.
- Execution may begin before or after subsequent code on the caller, depending on scheduling.
- Prefer async to keep UIs responsive and avoid blocking.

## Code samples


```swift

// MARK: - serial queue + calling code with sync
let serialQueue = DispatchQueue(label: "serial") // DispatchQueue(label) init creates a serial queue

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

## Main Thread vs. Background Thread (Global Thread)


## Other

- AsyncAfter
- (NS)Operation and (NS)OperationQueue
- Deadlock
- Main Thread Checker
- Async / Await / Actor Is iOS13+

## Useful links

- https://betterprogramming.pub/the-complete-guide-to-concurrency-and-multithreading-in-ios-59c5606795ca#b3d8
- https://medium.com/geekculture/threads-in-ios-gcd-nsoperation-part-1-64e460c0bdea
- https://khanumair-9430.medium.com/gcd-dispatchworkitem-swift-cancelling-a-task-in-dispatch-68da958c5b20
- Dispatch Group vs Operation — iOS Swift:
    - https://medium.com/@basnurevinod/dispatch-group-vs-operation-ios-swift-3a62540e6b1b#:~:text=With%20GCD%20Queues%20(Dispatch%20Queues,as%20we%20call%20in%20Operation.
- https://medium.com/@sizonov.9595/difference-between-sync-and-async-in-serial-and-concurrent-queues-70bdf57bb6ab