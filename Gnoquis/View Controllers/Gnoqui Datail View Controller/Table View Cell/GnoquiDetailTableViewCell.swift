//
//  GnoquiDetailTableViewCell.swift
//  Gnoquis
//
//  Created by kino on 4/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

class GnoquiDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var campoLabel: UILabel!

    @IBOutlet weak var valorLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(withViewModel viewModel : GnoquiViewViewModel, indexPath: Int) {
        switch indexPath {
        case 0:
            campoLabel.text = NSLocalizedString("Name",comment: "")
            valorLabel.text = viewModel.name
        case 1:
            campoLabel.text = NSLocalizedString("Age",comment: "")
            valorLabel.text = String(viewModel.age)
            
        case 2:
            campoLabel.text = NSLocalizedString("Height",comment: "")
            valorLabel.text =  String(viewModel.height)
        case 3:
            campoLabel.text = NSLocalizedString("Weight", comment: "")
            valorLabel.text = String(viewModel.weight)
        case 4:
            campoLabel.text = NSLocalizedString("Hair color", comment: "")
            valorLabel.text = viewModel.hair_color
        case 5:
            campoLabel.text = NSLocalizedString("Professions", comment: "")
            valorLabel.text = viewModel.professions.joined(separator: ", ")
        case 6:
            campoLabel.text = NSLocalizedString("Friends", comment: "")
            valorLabel.text = viewModel.friends.joined(separator: ", ")
 

        default:
            campoLabel.text = ""
            valorLabel.text = ""
        }

    }
}
