//
//  MenuViewController.swift
//  Gnoquis
//
//  Created by kino on 10/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    //Referencia al delegate
    var menuItems = ["Hamburguer","Id", "Name", "Age", "Weight", "Height"]
   
    @IBOutlet weak var tableView: UITableView!
    var delegate: MenuViewControllerDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func getFilter(_ sender: UIButton) {
        let txt = sender.titleLabel?.text
        passDataBackwards(txt: txt!)
    }
    
    func passDataBackwards(txt : String) {
        let data = txt
        delegate?.retornoValor(with: data)
        dismiss(animated: true, completion: nil)
        
    }
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MenuViewControllerTableViewCell
        print("menuItem : \(menuItems[indexPath.row])")
        cell.configure(data: menuItems[indexPath.row])

        
        return cell
    }
}
