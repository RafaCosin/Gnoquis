//
//  GnoquiViewController.swift
//  Gnoquis
//
//  Created by kino on 2/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit
import  CoreData

class GnoquiViewController: UIViewController {
    var arrayGnoquis = [GnoquisMO]()
    var viewModel: GnoquiViewViewModel!
    var gnoquiStorage = GnoquiStorageController()
    
    //working area
    var data: String!
    var hayDatos: Bool!
    let key = coreDataLoad
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hayDatos = getUserDefaults(key: key)
        
        if !hayDatos {
           getJson(url: gnomesURL!)
           setUserDefaults(key: key)
         }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if  arrayGnoquis.count == 0  {
            arrayGnoquis = gnoquiStorage.fetchCoreData()
        }
        tableView.reloadData()
        return
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGnoquiDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
               let destinationController = segue.destination as! GnoquiDetailViewController
                destinationController.gnoquiStruct = arrayGnoquis[indexPath.row]
            }
        }
        
        if segue.identifier == "showMenu" {
            if let destination = segue.destination as? MenuViewController {
                destination.delegate = self
            }
        }

        
    }
}

//* Tratamiento del pase de parametros desde Menu gnoquis

extension GnoquiViewController: MenuViewControllerDelegate {
    func retornoValor(with: String) {

        if  !with.isEmpty && with != cancelTXT {
            data = with
        
            arrayGnoquis = gnoquiStorage.fetchGnoquis(filtro: with)
        }
     
    }
    
 
}
extension GnoquiViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGnoquis.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GnoquiTableViewCell
 
        viewModel = GnoquiViewViewModel(gnoqui: arrayGnoquis[indexPath.row])
 
        if let viewModel = viewModel  {
            cell.configure(withViewModel: viewModel)
        }
    return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if data != nil {
            let unwarp = data!
            let order = NSLocalizedString("order by" ,comment: "")
            return  order + " " + unwarp
        }
         return ""
    }

}
extension GnoquiViewController {
     
     func getJson(url: URL) {
         let gnoquiStorage = GnoquiStorageController()
         let context = gnoquiStorage.context
        
        
         let urlSession = URLSession.shared
         let task = urlSession.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
         //            if let response = response {
         //                print(response)
         //                return
         //            }
                if let error = error {
                        print(error)
                        return
                }
             if let data = data {
                self.arrayGnoquis = self.parseJsonMO(data: data, context: context)
                if !self.arrayGnoquis.isEmpty {
                    self.saveArrayGnoqui(gnoquiMO: self.arrayGnoquis, context: context)
                }
             
                OperationQueue.main.addOperation({ () -> Void in
                    self.arrayGnoquis = self.gnoquiStorage.fetchCoreData()
                    self.tableView.reloadData()
                })
             }
         })
         task.resume()
     }
    
    func parseJsonMO(data: Data, context : NSManagedObjectContext) -> [GnoquisMO] {
        
        var gnoquisMO = [GnoquisMO]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            // Parse JSON data
            let jsonGnoquis = jsonResult?["Brastlewark"] as! [AnyObject]
            for jsonGnoqui in jsonGnoquis {
                let gnoqui = GnoquisMO(context: context)
                
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
    
    func saveArrayGnoqui(gnoquiMO: [GnoquisMO], context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            let saveError = error as NSError
            print("ERROR in load entity Gnoqui")
            print("Error : \(saveError)  info: \(saveError.localizedDescription)")
            
        }
    }
}

