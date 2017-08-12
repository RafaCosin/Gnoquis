//
//  GnoquiAboutViewController.swift
//  Gnoquis
//
//  Created by kino on 11/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

class GnoquiAboutViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var imgAbout: UIImageView!
    
    @IBOutlet weak var textAbout: UITextView!

    @IBOutlet var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.topItem?.title = NSLocalizedString("tittleAbout", comment: "")
        textAbout.text = NSLocalizedString("linesAbout", comment: "")
        setImageBackground(view: mainView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func doneButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
