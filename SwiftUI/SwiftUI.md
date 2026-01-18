# SwiftUI

- in SwiftUI, you don't manipulate the UI directly. You change some state and that will cause the UI to refresh
- `@State` - property wrapper that marks 'something' as the source of truth for a view. It is local to that View (NOT shared across multiple views). SwiftUI stores `@State` in a separate place from the View struct so that when the view refreshes, the state persists.
- When you mark something with `@State`, SwiftUI moves it into a persistent storage container. The property wrapper gives you 'access' to that storage so you can read and write to that value.
- If you need to share state, use `@ObservedObject` or `@EnvironmentObject`
- If your view has complex data logic, use `@StateObject` instead of `@State`
- Use `@StateObject` when owning a reference type (ie initialize a ViewModel object inside a View)
- Use `@ObservedObject` when NOT owning the reference type. You just 'observe' it, you are not its owner
- Navigation is done via: `NavigationStack`, `NavigationLink`, `.navigationTitle` 

## Credits

- [5 SwiftUI Best Practices Every iOS Developer Should Master](https://medium.com/@vrxrszsb/5-swiftui-best-practices-every-ios-developer-should-master-in-2024-4af4096a0856)
- [5 more SwiftUI best practices](https://medium.com/@vrxrszsb/5-more-swiftui-best-practices-every-ios-developer-should-master-3cd66a17a348)
- [Apple's SwiftUI tutorials](https://developer.apple.com/tutorials/swiftui)
- [Understanding @State in SwiftUI](https://medium.com/@hanzlarafique0/understanding-state-in-swiftui-a-practical-guide-for-ios-developers-a6720af7db4c)
- [Adding a search interface to your app](https://developer.apple.com/documentation/SwiftUI/Adding-a-search-interface-to-your-app)
- [Understanding the navigation stack](https://developer.apple.com/documentation/swiftui/understanding-the-composition-of-navigation-stack)

