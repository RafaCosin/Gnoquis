//
//  GnoquiViewViewModel.swift
//  Gnoquis
//
//  Created by kino on 2/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

struct GnoquiViewViewModel {
    let gnoqui: Gnoqui
    
    var id: Int {
        return gnoqui.id
    }
    
    var name: String {
        return gnoqui.name
    }
    
    var age: Int {
        return gnoqui.age
    }
    var weight: Double {
        return gnoqui.weight
    }
    var height: Double {
        return gnoqui.height
    }
    
    var hair_color: String {
        return gnoqui.hair_color
    }
    var professions: [String] {
        if gnoqui.professions.count > 0 {
               return gnoqui.professions
        } else {
            return []
        }
    }
    var friends: [String] {
        
        if gnoqui.friends.count > 0 {
            return gnoqui.friends
        } else {
            return []
        }
    }
    var thumbail: String {
        if  gnoqui.thumbnail != "" {
            return gnoqui.thumbnail
        }
        return ""
    }
    
}


