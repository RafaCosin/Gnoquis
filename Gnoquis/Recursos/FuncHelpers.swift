//
//  FuncHelpers.swift
//  Gnoquis
//
//  Created by kino on 3/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

// MARK: Leer de UserDefaults
func getUserDefaults(key: String) -> Bool {
    let defaults = UserDefaults.standard
    
    return defaults.bool(forKey: key)
}
//MARK: Write en UserDefaults
func setUserDefaults(key: String) {
    let defaults = UserDefaults.standard
    
    let userDefault = defaults.bool(forKey: key)
    if userDefault == false {
        
        defaults.set(true, forKey:key)
        
    }
}
    
func changeHttps(urlString : String)-> String{
    
        let aString = urlString
        let newString = aString.replacingOccurrences(of: "http:", with: "https:")
        return newString
}

//para no dibujar rows vacios
func prepareTableView(tableView : UITableView) {
    tableView.tableFooterView = UIView(frame: .zero)
    tableView.separatorStyle = .none
}

func setImageBackground(view: UIView) {
    UIGraphicsBeginImageContext(view.frame.size)
    UIImage(named: imgBckView)?.draw(in: view.bounds)
    
    if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(){
        UIGraphicsEndImageContext()
         view.backgroundColor = UIColor(patternImage: image)
    }else{
        UIGraphicsEndImageContext()
        debugPrint("Image not available")
    }
}

