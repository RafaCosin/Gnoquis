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
    
    func configure(data : String ) {
        print("data: \(data)")
        
        boton.setTitle(data, for: .normal)
        imgView.image = cargaIcono(iconName:data)
    }
    func cargaIcono(iconName: String) -> UIImage {
        if iconName != "Hamburguer" {
            return UIImage(named: "Hamburger")!
        }
        return UIImage(named: "duende_molon")!
    }
}
