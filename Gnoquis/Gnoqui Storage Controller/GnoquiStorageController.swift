//
//  GnoquiStorageController.swift
//  Gnoquis
//
//  Created by kino on 6/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import Foundation
import CoreData

class GnoquiStorageController {
    
    var coreDataStack : CoreDataStack
    var context: NSManagedObjectContext
    
    init() {
        coreDataStack = CoreDataStack()
        context = coreDataStack.persistentContainer.viewContext


    }


    //Read todos los gnoquis Gnoquis
    func fetchCoreData() -> [GnoquisMO] {
        print("fetch coredata en storage controller")
        var fetchResultController : NSFetchedResultsController<GnoquisMO>
        
        var arrayGnoquis: [GnoquisMO] = []
        
        let fetchRequest : NSFetchRequest<GnoquisMO> = GnoquisMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest , managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        
        do {
            try fetchResultController.performFetch()
            if let fetcheObjects = fetchResultController.fetchedObjects {
                arrayGnoquis = fetcheObjects
                
            }
        } catch let error as NSError  {
            print("Fetch Gnoquis error :\(error.localizedDescription)")
        }
        return arrayGnoquis
        
    }
    // Seleccion  de un criterio
    func fetchGnoquis (filtro : String) -> [GnoquisMO] {
        
        var gnoquis: [GnoquisMO] = []
        let criterio = String(filtro).lowercased()
        
        var fetchResultController : NSFetchedResultsController<GnoquisMO>
        let fetchRequest : NSFetchRequest<GnoquisMO> = GnoquisMO.fetchRequest()
        //clausulas de filtro
       
            
//    
//        let predicate1 = NSPredicate(format: "name == %@", filtro)
//        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1] )
//        fetchRequest.predicate = predicate
        
        //Ordenacion
        let sortDescriptor = NSSortDescriptor(key: criterio, ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        //Fetch
        fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest , managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchResultController.performFetch()
            if let fetcheObjects = fetchResultController.fetchedObjects {
                gnoquis = fetcheObjects
            }
        } catch let error as NSError  {
            print("Fetch Gnoquis error :\(error)")
        }
        return gnoquis
    }
    
}
