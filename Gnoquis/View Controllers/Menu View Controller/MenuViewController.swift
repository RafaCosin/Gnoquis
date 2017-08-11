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
   var menuItems = ["Id", "Name", "Age", "Hair_color", "Weight", "Height"]
   var iconItems = ["Inspector_Gnome-icon","Gangster_Gnome-icon","Monster_Costume_Gnome-icon","Headless_Gnome-icon","Season_Spirit_Gnome-icon","Haunted_Fairy_Gnomette-icon"]

    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        passDataBackwards(txt: "Cancel")
    }
    @IBOutlet weak var tableView: UITableView!
    //Referencia a VC que llama
    var delegate: MenuViewControllerDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
        setHeader()
        setImageBackground()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func getFilter(_ sender: UIButton) {
        let txt = sender.titleLabel?.text
        passDataBackwards(txt: txt!)
    }
    
    func passDataBackwards(txt : String) {
        delegate?.retornoValor(with: txt)
        dismiss(animated: true, completion: nil)
        
    }
    func setImageBackground () {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "wpb2.jpg")?.draw(in: self.view.bounds)
        
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
    }
    func setHeader() {
        let origenHeader = CGPoint(x: 0, y: 0)
        let sizeHeader  = CGSize(width: 238, height: 70)
        let viewHeader: UIView = UIView.init(frame: CGRect(origin: origenHeader, size: sizeHeader))
        viewHeader.backgroundColor = UIColor(red: 0.130, green: 0.36, blue: 0.130, alpha: 1.0)
        
        let origenLabel = CGPoint(x: 100, y: 0)
        let sizeLabel = CGSize(width: 100, height: 70)
        let labelHeader: UILabel = UILabel.init(frame: CGRect(origin: origenLabel, size: sizeLabel))
        labelHeader.text = "Filters"
        viewHeader.addSubview(labelHeader)
       
        self.tableView.tableHeaderView = viewHeader
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
        
        cell.backgroundColor = UIColor(red: 0.130, green: 0.36, blue: 0.130, alpha: 1.0)
        
        cell.configure(data: menuItems[indexPath.row], icono: iconItems[indexPath.row])
   
        
        return cell
    }
    

    
}
