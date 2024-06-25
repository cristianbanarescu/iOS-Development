//
//  SwiftUI_CoreDataApp.swift
//  SwiftUI-CoreData
//
//  Created by Cristian Banarescu on 25.06.2024.
//

import SwiftUI

@main
struct SwiftUI_CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
