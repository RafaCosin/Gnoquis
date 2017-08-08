//
//  GnoquiViewViewModel.swift
//  Gnoquis
//
//  Created by kino on 2/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

struct GnoquiViewViewModel {
    let gnoqui: GnoquisMO
    
    var id: Int {
        return Int(gnoqui.id)
    }
    
    var name: String {
        if !((gnoqui.name?.isEmpty)!) {
            return gnoqui.name!
        }
        return ""
    }
    
    var age: Int {
        if gnoqui.age > 0 {
            return Int(gnoqui.age)
        }
        return 0
    }
    var weight: Double {
        if (gnoqui.weight > 0.0) {
            return gnoqui.weight
        }
        return 0.0
    }
    var height: Double {
        if (gnoqui.height > 0.0) {
            return gnoqui.height
        }
        return 0.0
    }
    
    var hair_color: String {
        if !(gnoqui.hair_color?.isEmpty)! {
           return gnoqui.hair_color!
        }
        return ""
    }
    var professions: [String] {
        if ((gnoqui.professions?.hashValue) != nil) {
            return gnoqui.professions as! [String]
        } else {
           return []
        }
    }
    var friends: [String] {
        
        if ((gnoqui.friends?.hashValue) != nil) {
            return gnoqui.friends as! [String]
        } else {
            return []
        }
    }
    var thumbail: String {
        if  gnoqui.thumbnail != nil {
            return gnoqui.thumbnail!
        }
        return ""
    }
    
}


