//
//  ContentView.swift
//  SwiftUI-States
//
//  Created by Cristian Banarescu on 14.08.2024.
//

import SwiftUI

/*
 Explains and shows differences between:
 
 @State:
 
 - use it as a simple source of truth for a view; ie a Boolean, Int, String, etc (value types);
 - value updates > body of the View will refresh
 
 @StateObject:
 
 - https://www.youtube.com/watch?v=VLUhZbz4arg
 - https://www.youtube.com/watch?v=RvzJLekIjRs
 - https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-stateobject-property-wrapper
 - https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-stateobject-to-create-and-monitor-external-objects
 - https://stackoverflow.com/questions/74946534/what-is-the-difference-between-state-and-stateobject-in-swiftui
 - https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-observedobject-property-wrapper
 - https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-observedobject-to-manage-state-from-external-objects
 - use it when your view creates it first; if you (a View) are creating this first, use @StateObject
 - this makes sure that this object will stay alive along with the current view
 - has persistence; when the view redraws itself a StateObject will remain persistent through the lifetime of the view
 - use @StateObject only once per object > whichever view is responsible for creating the object; the other views should just use @ObservedObject
 - use it to create observed objects and not for storing objects that were passed from outside current view
 - a View with a property of an StateObject => that View OWNS the object
 - use @StateObject to create the object and then pass it along other views using @ObservedObject
 
 
 @ObservedObject:
 
 - when a view with an observedObject is placed inside another view (which has own state) and the state of the parent view changes, the 'child view' (with the observed object) will be refreshed and all the 'state' of the child view will be reset; this reset does not happen if child object uses its own 'StateObject'
 - other views (who don't OWN the object) will watch for when values inside the ObservedObject change
 - DO NOT USE IT TO ACTUALLY CREATE THE OBJECT
 - USE IT ONLY WITH OBJECTS THAT WERE CREATED ELSEWHERE, NOT IN CURRENT VIEW
 - might be shared acorss multiple views
 
 
 @EnvironmentObject:
 
 -
 
 
 - @State, @StateObject, @GestureState > the current view owns this data
 */

// ObservableObject > conforming types can be used inside views so that when important changes happen to Published properties, the views will know and will reload their UI
class CountManager: ObservableObject {
    @Published var count: Int = 0
}

struct CountView: View {
    @StateObject var countManager = CountManager() // let this be a StateObject instead of an ObservedObject so that CountView maintains CountManager alive for the duration of CountView's life
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
    
    var body: some View {
        VStack {
            Button("Increase counter") {
                counter += 1
            }
            
            Text("ContentView Counter: \(counter)")
            
            CountView() // using this and @ObservedObject inside the CountView, will reset the value of countManager.count whenever ContentView refreshes itself (when count for ContentView changes)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
