//
//  GetData.swift
//  Gnoquis
//
//  Created by kino on 8/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import Foundation
import CoreData

class GetData {
    var gnoquisMO = [GnoquisMO]()
    var coreDataStack : CoreDataStack
    var context : NSManagedObjectContext
    
    init() {
        self.coreDataStack = CoreDataStack()
        self.context = coreDataStack.persistentContainer.viewContext
        
    }
    
    func getJson(url: URL) {
        
        //let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                print("ERROR FILE FROM URL: \(String(describing: error))")
                return
            }
            // Parse JSON data
            if let data = data {
                self.gnoquisMO = self.parseJsonMO(data: data)
                if !self.gnoquisMO.isEmpty {
                    print(self.gnoquisMO)
                    self.saveArrayGnoqui(gnoquiMO: self.gnoquisMO )
                    
                }
                
            }
        }).resume()
        
    }
    
    func parseJsonMO(data: Data) -> [GnoquisMO] {
        
        var gnoquisMO = [GnoquisMO]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            // Parse JSON data
            let jsonGnoquis = jsonResult?["Brastlewark"] as! [AnyObject]
            for jsonGnoqui in jsonGnoquis {
                let gnoqui = GnoquisMO(context: self.context)
                
                gnoqui.id = Int16(jsonGnoqui["id"] as! Int)
                gnoqui.name = jsonGnoqui["name"] as? String
                gnoqui.thumbnail = changeHttps(urlString:jsonGnoqui["thumbnail"] as! String)
                gnoqui.age = Int16(jsonGnoqui["age"] as! Int)
                gnoqui.weight = jsonGnoqui["weight"] as! Double
                gnoqui.height = jsonGnoqui["height"] as! Double
                gnoqui.hair_color = jsonGnoqui["hair_color"] as? String
                gnoqui.professions = jsonGnoqui["professions"] as! [String] as NSObject
                gnoqui.friends = jsonGnoqui["friends"] as! [String] as NSObject
                gnoquisMO.append(gnoqui)
            }
            
        } catch {
            print(error)
        }
        return gnoquisMO
    }

    func saveArrayGnoqui(gnoquiMO: [GnoquisMO]) {
        do {
            try context.save()
        } catch {
            let saveError = error as NSError
            print("ERROR in load entity Gnoqui")
            print("Error : \(saveError)  info: \(saveError.localizedDescription)")
            
        }
    }
}
