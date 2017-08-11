//
//  MenuViewControllerTableViewCell.swift
//  Gnoquis
//
//  Created by kino on 10/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

class MenuViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var boton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(data : String, icono: String? ) {
        let data = data
        let filters = "Filters"
        boton.setTitle(data, for: .normal)
        if data ==  filters || data == "Salto"{
            boton.isEnabled = false
            boton.isUserInteractionEnabled = false
            //boton.setTitle(data, for: .selected)
        }
        imgView.image = cargaIcono(iconName: icono!)

    }
    
    func cargaIcono(iconName: String) -> UIImage {
        let iconFTF = UIImage(named: "halloween-father-and-son-gnome")
        if !iconName.isEmpty {
            return UIImage(named: iconName)!
        }
        return iconFTF!

//        return UIImage(named: "duende_molon")!
    }
}
