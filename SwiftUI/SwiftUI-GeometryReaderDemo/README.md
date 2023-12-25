# GeometryReader in SwiftUI 

## What is it? How to use?

- Container view that lets you inspect properties (height, width, etc) related to size of the parent view, so that you can position child views inside correctly
    - height, width, safe area insets, frame of the geometry reader inside the parent view, etc
- Useful to give views a 'dynamic' size so that all views can look good on any device
    - use the geometryReader's proxy parameter to give views heights and widths rather than using fixex heights and widths
    - using the proxy, your views will look great on different devices with different sizes
- It is a container view that takes up all the available space of its parent
- You can use it to get the coordinates of the GeometryReader inside a parent view and use these coordinates to arrange views inside
