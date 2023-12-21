#  Layout Priority in SwiftUI 

## How layouts can shrink or stretch

- Use the `.layoutPriority` modifier
    - used to let a parent view know how to distribute/allocate space to child views 
- Takes a Double as a parameter:
    - the higher the value, the more space a view will get, in comparison to a view with a lower priority
    - the higher the value > the view will shrink later or stretch sooner than other views 
    - 0 > space is distributed evenly inside a parent view
- Similar to how NSLayoutConstraints have their priority (https://developer.apple.com/documentation/appkit/nslayoutconstraint/priority)
