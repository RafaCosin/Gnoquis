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
    var menuItems = ["Id", "Name", "Age", "Hair color", "Weight", "Height"]
   
    @IBOutlet weak var tableView: UITableView!
    var delegate: MenuViewControllerDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "Nature-Blur-11.jpg")?.draw(in: self.view.bounds)
        
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! MenuViewControllerTableViewCell
        cell.configure(data: menuItems[indexPath.row])

        
        return cell
    }
}
