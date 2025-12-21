//
//  PulseApp.swift
//  Pulse
//
//  Created by Cristian Banarescu on 20.12.2025.
//

import SwiftUI

/// @main - entry point of the app ; replaces `UIApplicationMain`/`AppDelegate`; SwiftUI controls the lifecycle from here
///
/// `App` protocol with `body` property requirement; conforming to App protocol means to describe what scenes exist; not necessarily 'how' to manage them
///
/// `Scene` is also a protocol; a Scene describes a container for UI
///
/// `WindowGroup` can create multiple windows > `A scene that presents a group of identically structured windows.`
///
/// SwiftUI decides how many windows exist and when to present them
///
/// In SwiftUI you decide what the UI should look like for a given state, not HOW to update the UI (SwiftUI does that)
@main
struct PulseApp: App {
    var body: some Scene {
        WindowGroup {
            FeedView(activities: [
                Activity(id: "1", title: "first one", body: "first one body"),
                Activity(id: "2", title: "second one", body: "second one body"),
                Activity(id: "3", title: "third one", body: "third one body"),
            ])
//                .environment(\.colorScheme, .dark) // environment injection
        }
    }
}

/*
 When state of some view changes:
 
 - SwiftUI re-evaluates the body property
 - new views are produced (so the views are not mutated like in UIKit, they are re-created because they are structs and that is cheap and fast to re-create)
 - SwiftUI diffs the result; creates the 'new' view hierarchy, compares it with the 'old' one and only the changed parts are actually updated on the screen; it uses diffing and identity checks to only update what changed. 'SwiftUI is not literally repainting every pixel every time; it’s smart about minimal changes.'
 - screen updates
 - no view objects are mutated (as they are in UIKit)
 
 TLDR: change the state -> refresh the UI
 */
