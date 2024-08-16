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
 
 @StateObject:

 - use it when your view creates it first; if you (a View) are creating this first, use @StateObject
 - this makes sure that this object will stay alive along with the current view
 - has persistence; when the view redraws itself a StateObject will remain persistent through the lifetime of the view
 - use @StateObject only once per object > whichever view is responsible for creating the object; the other views should just use @ObservedObject
 - use it to create observed objects and not for storing objects that were passed from outside current view
 - a View with a property of an StateObject => that View OWNS the object
 - use @StateObject to create the object and then pass it along other views using @ObservedObject
 
 
 @ObservedObject:
 
 - object is more complex than just a simple @State; has more properties and methods
 - when a view with an observedObject is placed inside another view (which has own state) and the state of the parent view changes, the 'child view' (with the observed object) will be refreshed and all the 'state' of the child view will be reset; this reset does not happen if child object uses its own 'StateObject'
 - other views (who don't OWN the object) will watch for when values inside the ObservedObject change
 - DO NOT USE IT TO ACTUALLY CREATE THE OBJECT
 - USE IT ONLY WITH OBJECTS THAT WERE CREATED ELSEWHERE, NOT IN CURRENT VIEW
 - might be shared acorss multiple views > multiple views will refresh based on when a Published property value changes
 
 
 @EnvironmentObject:
 
 - object made available to multiple views using the app itself ; shared data that every view can watch for
 - you don't assign a value to an @EnvironmentObject object
 - you create the object elsewhere and just pass it along inside the subviews using the .environmentObject() modifier
 - Using this property wrapper, you declare the type of thing you expect to receive but you do not create it – you’re expecting to receive it from the environment
 - If you need multiple objects to the environment you can add multiple environmentObject() modifiers one after the other
 
 - @State, @StateObject, @GestureState > the current view owns this data
 */

// ObservableObject > conforming types can be used inside views so that when important changes happen to Published properties, the views will know and will reload their UI
class CountManager: ObservableObject {
    @Published var count: Int = 0
}

struct CountView: View {
    @EnvironmentObject var countManager: CountManager // let this be a StateObject instead of an ObservedObject so that CountView maintains CountManager alive for the duration of CountView's life
    // here, CountView is the owner of CountManager

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
            
            CountView() // using this and @ObservedObject inside the CountView, will reset the value of countManager.count whenever ContentView refreshes itself (when count for ContentView changes)
            
            InsideView()
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

#Preview {
    ContentView()
}
