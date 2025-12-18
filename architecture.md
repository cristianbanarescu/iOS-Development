# iOS Architecture, Design patterns, principles

## DRY (Don't repeat yourself)

- write clean, maintainable and scalable code instead of writing the same piece of code over and over again
- reduce repetition
- write some code and reuse it in other places
- use protocols to create a common place where to 'store' shared behavior
- create helpers or extensions for UI usages/patterns
- move constants into enums or config files
- try to avoide copy-pasting code as much as possible

```swift
// before
button.layer.cornerRadius = 10
button.layer.borderWidth = 2
button.layer.borderColor = UIColor.blue.cgColor

// after
extension UIButton {
    func styleAsBorderedAndRounded() { // can be used for every UIButton instead of adding/calling/using the code above over and over again 
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.blue.cgColor
    }
}
```

```swift
// before 
URLSession.shared.dataTask(with: request) { data, _, _ in // this will be called in all places we want to fetch some data and decode it
    // decode JSON
}

// after
class NetworkManager { // use this manager everywhere you want to fetch data and decode it
    static let shared = NetworkManager()

    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return completion(nil) }
            let decoded = try? JSONDecoder().decode(T.self, from: data)
            completion(decoded)
        }.resume()
    }
}
```

```swift
// before
Text("Hello")
    .font(.headline)
    .foregroundColor(.blue)
    .padding()

// after
extension View {
    func primaryStyle() -> some View {
        self
            .font(.headline)
            .foregroundColor(.blue)
            .padding()
    }
}

Text("Hello").primaryStyle()

// or 
struct TextWithBlueForeground: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.blue)
            .padding()
    }
}

TextWithBlueForeground(text: "Hello")
```

## Dependency Inversion 

- decouple logic 
- don't depend on concrete objects; depend on and use abstractions (protocols)
- easier to change logic when you depend on an abstraction
- helps with tests and mocking data

```swift
class ViewModel {
    let service = NetworkService() // hardwired; unable to test ViewModel properly without actually calling the API and fetch data from inside NetworkService
    // what if you want to change NetworkService and fetch data in another way (maybe from disk, cache, etc)? What code updates do you need?
    
    func fetchData() {
        service.getData()
    }
}

class NetworkService {
    func getData() {
        // fetch from an API
    }
}

// solution

protocol Fetcher {
    func getData()
}

class ViewModelFixed {
    let service: Fetcher
    
    init(service: Fetcher) {
        self.service = service
    }
    
    func fetchData() {
        service.getData()
    }
}

class MockService: Fetcher { // use in testing and don't actually fetch anything; you don't need to fetch in tests
    func getData() {
        print("Mocked data fetch")
    }
}

let viewModel = ViewModelFixed(service: MockService())

class DiskService: Fetcher {
    func getData() {
        print("get data from disk")
    }
}

let viewModelWithReadFromDisk = ViewModelFixed(service: DiskService())
```

## Credits

- [DRY in Swift: Write Clean, Reusable Code](https://medium.com/@ios-interview/dry-in-swift-write-clean-reusable-code-f6e75239254e)
- [Stop hardcoding and use dependency inversion](https://medium.com/@shobhakartiwari/swift-dependency-inversion-why-i-stopped-hardcoding-66db1c108803)