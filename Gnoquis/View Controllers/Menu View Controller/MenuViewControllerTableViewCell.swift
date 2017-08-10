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
        boton.setTitle(data, for: .normal)
        if let ico = icono {
            imgView.image = cargaIcono(iconName: ico)
        }
        imgView.image = cargaIcono(iconName: icono!)
    }
    
    func cargaIcono(iconName: String) -> UIImage {
        if !iconName.isEmpty {
            return UIImage(named: iconName)!
        }
        return UIImage(named: "duende_molon")!
    }
}
