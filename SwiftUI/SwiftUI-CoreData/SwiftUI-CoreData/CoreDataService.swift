//
//  CoreDataService.swift
//  SwiftUI-CoreData
//
//  Created by Cristian Banarescu on 25.06.2024.
//

import CoreData
import SwiftUI

/// Use this object together with its embedded NSManagedObjectContext in order to:
///  - fetch data > viewContext.fetch(fetchRequest)
///  - insert data > Item(context: viewContext)
///  - delete data > viewContext.delete(item)
class CoreDataService: ObservableObject {
    private var viewContext: NSManagedObjectContext
    @Published var items: [Item] = []
    
    static let shared = CoreDataService(viewContext: NSManagedObjectContext.current)
    
    private init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        
        getItems()
    }
    
    // MARK: - Fetch data
    
    private func getItems() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)]
        
        do {
            items = try viewContext.fetch(fetchRequest)
        } catch  {
            items = []
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Add/Insert data
    
    func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            items.append(newItem)

            saveContext()
        }
    }

    // MARK: - Delete data
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach { item in
                items.removeAll { existingItem in
                    existingItem == item
                }
                viewContext.delete(item)
            }

            saveContext()
        }
    }
    
    // MARK: - Save state of context
    fileprivate func saveContext() {
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

// NSPersistentContainer > NSManagedObjectContext
// For graphical representation, see https://developer.apple.com/documentation/coredata/core_data_stack

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext {
        let container = NSPersistentContainer(name: "SwiftUI_CoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        return container.viewContext
    }
}
