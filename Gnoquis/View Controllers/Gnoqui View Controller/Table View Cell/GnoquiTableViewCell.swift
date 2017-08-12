//
//  GnoquiTableViewCell.swift
//  Gnoquis
//
//  Created by kino on 2/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

enum DataValues: String {
    case id = "Id"
    case age = "Age"
    case weight = "Weight"
    case height = "Height"
    case hair_color = "Hair_color"
    case professions = "Professions"
    case friends = "Friends"
 }
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
    func configure(withViewModel viewModel : GnoquiViewViewModel, data: String) {
        nameLabel.text = viewModel.name
        
        
        switch data {
            case DataValues.id.rawValue:
                professionLabel.text = String(viewModel.id)
            case DataValues.age.rawValue:
                professionLabel.text = String(viewModel.age)
            case DataValues.weight.rawValue:
                professionLabel.text = String(viewModel.weight)
            case DataValues.height.rawValue:
                professionLabel.text = String(viewModel.height)
            case DataValues.hair_color.rawValue:
                professionLabel.text =  viewModel.hair_color
            
            default:
                professionLabel.text = viewModel.professions.joined(separator: ", ")
        }
        
        iconoImg.loadImageUsingCache(withUrl: viewModel.thumbail)   
    }
    
}
