# iOS Memory Management

- Stack and heap are different regions of a process's memory that Swift uses.

## Stack

- place in memory to store: function calls, parameters, local variables, temporary values
- use for value types: struct, enum, primitive types
- LIFO structure
- 'tear off' the memory when a function ends
- fast but limited in size 
- automatic cleanup 
- function calls creates stack frames (basically when you call a function, that call is 'seen' in the stack)
- 'compile time memory'
- quickly accessing variables from memory
- there will be cases in which a struct can be allocated on the heap: when the struct is a variable inside a class, in an escaping closure, inout parameter
- stack memory does not have deinitializers

```swift
func addNumbers() {
    let a = 10   // a stored on stack
    let b = 20   // b stored onstack
    let c = a + b  // c stored on stack
    print(c)
}
// when this function ends, the stack frame is popped and memory is freed
```

```swift
struct User {
    var name: String
}

func asyncExample() {
    var user = User(name: "Alice") // 'user' variable would normally be stored on the stack
    DispatchQueue.global().async {
        print(user.name) // capture 'user' by reference; this will be a 'frozen copy' > meaning that you have the 'user' at this point in time; if something changes for it , you won't necessarily have the 'latest' value
    }
}
// in this case, 'user' is captured by a closure ; Swift makes a copy of it and stores it in that closure's capture context; closure escapes > whole capture context of the closure is stored on the heap
```

## Heap

- place in memory to store: objects, classes, large dynamic allocations
- use for reference types: class, escaping closures, captured variables, shared mutable state
- basically the Heap stores more 'complicated' types and objects when compared to the Stack
- managed by ARC in Swift
- slower than stack (ARC needs to track references)
- larger than stack 
- 'runtime memory'
- more dynamically allocated blocks 
- store more complex hierarchies of information
- only heap-allocated class instances have a `deinit`
- Xcode's Memory Graph viewer shows all heap allocations and strong references between objects
- used for allocations with uknown or extended lifetime

```swift
class Person {
    var name: String
    init(name: String) { 
      self.name = name 
    }
}

func createPerson() {
    let p = Person(name: "Anubhav") // 'p' (the constant) lives on the Stack, but the instance, Person(name:...) lives on the heap
    print(p.name)
    // when there aren't any references to Person, ARC will free the memory for it
}
```

## Crashes

- basically mean there is a problem created by you, the programmer
- invalid memory access
- Examples:
    - stack overflow
    - force unwrapping a nil 
    - use an object after its memory has been freed
- iOS will show you a `EXC_BAD_ACCESS` error in xcode and logs

## Kills

- OS does this because app is using too much heap memory
- OS terminates the app to save RAM 

## Notes 

- Stack is like your kitchen's countertop: fast, organized, easy to clean when you're done (memory is freed when a function ends)
- Heap is like your pantry: slower to access but can store lots of things; doesn't get wiped clean until you do it manually (ARC does this in Swift)
- Use Instruments and Zombies to detect leaks and invalid memory
- Stack allocates function variables and arguments and heap allocates dynamic objects or objects that have some lifetime

## Credits

- https://anubhavgiri01.medium.com/understanding-memory-in-ios-stack-vs-heap-crashes-and-handling-cc22a65b8090
- https://blog.stackademic.com/stack-vs-heap-in-swift-what-every-ios-developer-should-actually-know-71f8d0ab7810
- https://stackoverflow.com/questions/71071416/stack-and-heap-misunderstanding-in-swift
- [Stack vs Heap - simple explanation](https://www.youtube.com/watch?v=5OJRqkYbK-4)
- [What are Stack and Heap Memory?](https://www.youtube.com/watch?v=ep2xOW52mDY)
- [Stack vs Heap](https://www.youtube.com/watch?v=4ocXiQ6mIuk&t=269s)
- [Stack vs Heap repo](https://github.com/jrasmusson/ios-professional-course/blob/main/Knowing/StackVsHeap/README.md)