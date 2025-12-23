# SwiftUI - opaque types

## Basic explanation of the 'some' keyword

- `some View` = I don't have to know/don't 'care' what view (or combination of Views) there is to display; iOS will display it as long as it conforms to the `View` protocol

- 'opaque type’ = type where the value and implementation details are hidden

__NOTE__: When using and returning an opaque type, all return values MUST be `matching underlying types`. For more details, see [ContentViewWithError](SwiftUIOpaqueTypes/ContentView.swift)
