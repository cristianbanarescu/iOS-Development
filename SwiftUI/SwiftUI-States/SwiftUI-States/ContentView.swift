//
//  ContentView.swift
//  SwiftUI-States
//
//  Created by Cristian Banarescu on 14.08.2024.
//

import SwiftUI

/*
 
 - https://www.youtube.com/watch?v=VLUhZbz4arg
 - https://www.youtube.com/watch?v=RvzJLekIjRs
 - https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-stateobject-property-wrapper
 - https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-stateobject-to-create-and-monitor-external-objects
 - https://stackoverflow.com/questions/74946534/what-is-the-difference-between-state-and-stateobject-in-swiftui
 - https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-observedobject-property-wrapper
 - https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-observedobject-to-manage-state-from-external-objects
 - https://www.hackingwithswift.com/quick-start/swiftui/whats-the-difference-between-observedobject-state-and-environmentobject
 - https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
 
 Explains and shows differences between:
 
 @State:
 
 - use it as a simple source of truth for a view; ie a Boolean, Int, String, etc (value types); this state doesn't get outside of current View
 - value updates > body of the View will refresh
 - good idea to mark @State with private (private @State var number: Int = 0 ) to reinforce the fact that this State belongs only to current view
 - Example: some button from the current View changes some kind of state > increase the value of a counter and then show the updated value of the counter
 
 @StateObject:

 - use it when your view creates the object first; if you (a View) are creating this first, use @StateObject
 - this makes sure that this object will stay alive along with the current view
 - has persistence; when the view redraws itself a StateObject will remain persistent through the lifetime of the view
 - use @StateObject only once per object > whichever view is responsible for creating the object; the other views should just use @ObservedObject
 - use it to create observed objects and not for storing objects that were passed from outside current view (for that, use @ObservedObject)
 - a View with a property marked @StateObject => that View OWNS the object
 - use @StateObject to create the object and then 'read from it' inside other views using @ObservedObject
 
 
 @ObservedObject:
 
 - object is more complex than just a simple @State; has more properties and methods; some custom object that contains different properties
 - when a view with an @ObservedObject is placed inside another view (which has own state) and the state of the parent view changes, the 'child view' (with the observed object) will be refreshed and all the 'state' of the child view will be reset; this reset does not happen if child object uses its own 'StateObject'
 - other views (who don't OWN the object) will watch for when values inside the ObservedObject change
 - DO NOT USE IT TO ACTUALLY CREATE THE OBJECT
 - USE IT ONLY WITH OBJECTS THAT WERE CREATED ELSEWHERE, NOT IN CURRENT VIEW
 - might be shared acorss multiple views > multiple views will refresh based on when a Published property value changes
 
 
 @EnvironmentObject:
 
 - object made available to multiple views using the app itself ; shared data that every view can watch for (like when you need to 'watch' for updates inside a Singleton)
 - you don't assign a value to an @EnvironmentObject object
 - you create the object elsewhere and just pass it along inside the subviews using the .environmentObject() modifier
 - Using this property wrapper, you declare the type of thing you expect to receive but you DO NOT CREATE IT – you’re expecting to receive it from the environment
 - If you need multiple objects to the environment you can add multiple environmentObject() modifiers one after the other
 
 - @State, @StateObject, @GestureState > the current view owns this data
 */

// ObservableObject > conforming types can be used inside views so that when important changes happen to Published properties, the views will know and will reload their UI (only part of the UI that depends on the observed properties of the object)
class CountManager: ObservableObject {
    @Published var count: Int = 0
}

@Observable
class CountManagerWithObservable { // no need for ObservableObject
    var count: Int = 0 // no need for @Published
}

struct CountView: View {
    @ObservedObject var countManager: CountManager // let this be a StateObject instead of an ObservedObject so that CountView maintains CountManager alive for the duration of CountView's life
    // here, CountView is NOT the owner of CountManager (when using @EnvironmentObject; if using @StateObject, then yes, the CountView would be the owner of CountManager)

    var body: some View {
        VStack {
            Button("Increase counter from CountManager") {
                countManager.count += 1
            }
            Text("CountManager Counter: \(countManager.count)")
        }
    }
}

struct ContentView: View {
    @State var counter: Int = 0
    @StateObject var countManager = CountManager()
    
    var body: some View {
        VStack {
            Button("Increase counter") {
                countManager.count += 1
            }
            
            Text("ContentView Counter: \(countManager.count)")
            
            CountView(countManager: countManager)
            
            InsideView()
            
            ViewWithObservable()
        }
        .padding()
        .environmentObject(countManager) // this will pass CountManager to all the subviews; if you don't pass it here, Previews will crash
    }
}

struct InsideView: View {
    @EnvironmentObject var countManager: CountManager
    
    var body: some View {
        VStack {
            Text("Inside View using an environment object")
            Text("\(countManager.count)")
        }
    }
}

struct ViewWithObservable: View {
    // NO need for @StateObject
    let observedObject = CountManagerWithObservable()
    
    var body: some View {
        VStack {
            Button("Increase counter using @ObservableObject") {
                observedObject.count += 1
            }
            Text("Inside ViewWithObservable using an @ObservableObject")
            Text("Its count is: \(observedObject.count)")
        }
    }
}

#Preview {
    ContentView()
}
