//
//  GnoquiTableViewCell.swift
//  Gnoquis
//
//  Created by kino on 2/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

class GnoquiTableViewCell: UITableViewCell {

    @IBOutlet var iconoImg: UIImageView!
    @IBOutlet  var nameLabel: UILabel!
    @IBOutlet  var professionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(withViewModel viewModel : GnoquiViewViewModel) {
        nameLabel.text = viewModel.name
        professionLabel.text = viewModel.professions.joined(separator: ", ")
        iconoImg.loadImageUsingCache(withUrl: viewModel.thumbail)   
    }
    
}
