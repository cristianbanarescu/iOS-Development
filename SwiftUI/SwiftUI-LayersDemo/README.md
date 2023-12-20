#  Demo of SwiftUI layers

## How to use layers in SwiftUI 

### Adding a layer on top of a view

- using the `.overlay` modifier
- Ex:

```swift
    Image(systemName: "globe")
        .resizable()
        .frame(width: 200, height: 200)
        .overlay {
            Text("On top")
                .font(.title)
                .foregroundStyle(.white)
        }
``` 
- See more here: https://developer.apple.com/documentation/swiftui/view/overlay(alignment:content:)

### Adding a layer behind a view 

- using the `.background` modifier 
- Ex:

```swift
    Image(systemName: "globe")
        .resizable()
        .frame(width: 200, height: 200)
        .background(
            Circle()
                .foregroundStyle(.red)
        )
``` 
- See more here: https://developer.apple.com/documentation/swiftui/view/background(alignment:content:)
