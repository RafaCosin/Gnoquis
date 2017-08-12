//
//  MenuViewController.swift
//  Gnoquis
//
//  Created by kino on 10/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
   var menuItems = [ "FILTERS","Id", "Name", "Age", "Hair_color", "Weight", "Height", "INFO", "About"]
   var iconItems = ["lighthouse-keeper-gnome" ,"Inspector_Gnome-icon","Gangster_Gnome-icon","Monster_Costume_Gnome-icon","Haunted_Fairy_Gnomette-icon","Headless_Gnome-icon","Season_Spirit_Gnome-icon","", "troll-gnome"]

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //Referencia a VC que llama para retorno valores
    var delegate: MenuViewControllerDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView(tableView: tableView)
        setImageBackground(view: mainView)
       
    }

    @IBAction func getFilter(_ sender: UIButton) {
        let buttonText = sender.titleLabel?.text
        if buttonText == aboutTXT {
            
            performSegue(withIdentifier: "showAbout", sender: self)
        } else {
            passDataBackwards(txt: buttonText!)
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        passDataBackwards(txt: cancelTXT)
    }
    
    func passDataBackwards(txt : String) {
        delegate?.retornoValor(with: txt)
        dismiss(animated: true, completion: nil)
        
    }
    //MARK: Navegacion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAbout" {

  //          let destinationController = segue.destination as! GnoquiAboutViewController
//                destinationController.gnoquiStruct = arrayGnoquis[indexPath.row]
            
        }
    }
    
    override func unwind(for unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
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
        
        cell.configure(data: menuItems[indexPath.row], icono: iconItems[indexPath.row])

        return cell
    }
    
}


