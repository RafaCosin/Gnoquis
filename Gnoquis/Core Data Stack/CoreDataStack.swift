//
//  CoreDataStack.swift
//  Gnoquis
//
//  Created by kino on 6/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit
import CoreData
// MARK: - Core Data stack
class CoreDataStack {
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Gnoquis")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

// MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
