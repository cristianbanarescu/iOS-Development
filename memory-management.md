# iOS Memory Management

## Stack

- place in memory to store: function calls, parameters, local variables
- use for value types: struct, enum, primitive types
- LIFO structure
- 'tear off' the memory when a function ends
- fast but limited in size 
- automatic cleanup 
- function calls creates stack frames (basically when you call a function, that call is 'seen' in the stack)

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
    var user = User(name: "Alice") // 'user' constant would normally be stored on the stack
    DispatchQueue.global().async {
        print(user.name) // capture 'user'
    }
}
// in this case, 'user' is captured by a closure ; Swift makes a copy of it and stores it in that closure's capture context; closure escapes > whole capture context of the closure is stored on the heap
```

## Heap

- place in memory to store: objects, classes, large dynamic allocations
- use for reference types: class, closure, captured contexts
- basically the Heap stores more 'complicated' types and objects when compared to the Stack
- managed by ARC in Swift
- slower than stack (ARC needs to track references)
- larger than stack 

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
- ios will show you a `EXC_BAD_ACCESS` error in xcode and logs

## Kills

- OS does this because app is using too much heap memory
- OS terminates the app to save RAM 

## Notes 

- Stack is like your kitchen's countertop: fast, organized, easy to clean when you're done (memory is freed when a function ends)
- Heap is like your pantry: slower to access but can store lots of things; doesn't get wiped clean until you do it manually (ARC does this in Swift)
- use Instruments and Zombies to detect leaks and invalid memory
- Credits to:
    - https://anubhavgiri01.medium.com/understanding-memory-in-ios-stack-vs-heap-crashes-and-handling-cc22a65b8090
    - https://blog.stackademic.com/stack-vs-heap-in-swift-what-every-ios-developer-should-actually-know-71f8d0ab7810
    - https://stackoverflow.com/questions/71071416/stack-and-heap-misunderstanding-in-swift

