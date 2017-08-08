//
//  GnoquiDetailViewController.swift
//  Gnoquis
//
//  Created by kino on 3/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

class GnoquiDetailViewController: UIViewController {
  
    var viewModel: GnoquiViewViewModel!
    var gnoquiStruct : GnoquisMO!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var iconoImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTableview(table: tableView)
        viewModel = GnoquiViewViewModel(gnoqui: gnoquiStruct)
        iconoImg.loadImageUsingCache(withUrl: viewModel.thumbail)
    }
}
extension GnoquiDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GnoquiDetailTableViewCell
        if let viewModel = viewModel  {
            //
            cell.configure(withViewModel: viewModel, indexPath: indexPath.row)
        }
        return cell
    }
    func prepareTableview(table: UITableView) {
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorStyle = .none
    }
}
