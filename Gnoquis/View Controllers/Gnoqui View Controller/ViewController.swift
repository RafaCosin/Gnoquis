//
//  ViewController.swift
//  Gnoquis
//
//  Created by kino on 2/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var arrayGnoquis = [Gnoqui]()
    var viewModel: GnoquiViewViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        getLatestGnoquis()
        print("viewdidLoad -----> arrayGnoquis \(self.arrayGnoquis.count)")

 
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGnoquiDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
               let destinationController = segue.destination as! GnoquiDetailViewController
                destinationController.gnoquiStruct = arrayGnoquis[indexPath.row]
            }
        }
        
    }


}
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayGnoquis.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GnoquiTableViewCell
 
        viewModel = GnoquiViewViewModel(gnoqui: arrayGnoquis[indexPath.row])
 
    // Configure the cell...
        if let viewModel = viewModel  {
            //
            cell.configure(withViewModel: viewModel)
        }
    return cell
    }
    
}
extension ViewController {
    
    func getLatestGnoquis() {
     //   let request = URLRequest(url: URL(string: gnomesURL)!)
        let request = URLRequest(url: gnomesURL!)

        print(request)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
//            if let response = response {
//                print(response)
//                return
//            }
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON data
            if let data = data {
                self.arrayGnoquis = self.parseJsonData(data: data)
                // Reload table view
          
                OperationQueue.main.addOperation({ () -> Void in
                    self.tableView.reloadData()
                })
                
            }
            
        })
        
        task.resume()
    }
    
    
    func parseJsonData(data: Data) -> [Gnoqui] {
        
        var gnoquis = [Gnoqui]()
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            // Parse JSON data
            let jsonGnoquis = jsonResult?["Brastlewark"] as! [AnyObject]
            for jsonGnoqui in jsonGnoquis {
                var gnoqui = Gnoqui()
                
                gnoqui.id = jsonGnoqui["id"] as! Int
                gnoqui.name = jsonGnoqui["name"] as! String
                gnoqui.thumbnail = changeHttps(urlString:jsonGnoqui["thumbnail"] as! String)
                gnoqui.age = jsonGnoqui["age"] as! Int
                gnoqui.weight = jsonGnoqui["weight"] as! Double
                gnoqui.height = jsonGnoqui["height"] as! Double
                gnoqui.hair_color = jsonGnoqui["hair_color"] as! String
                gnoqui.professions = jsonGnoqui["professions"] as! [String]
                gnoqui.friends = jsonGnoqui["friends"] as! [String]
                //print(gnoqui)
                gnoquis.append(gnoqui)
            }
            
        } catch {
            print(error)
        }
        
        return gnoquis
    }
    
}
