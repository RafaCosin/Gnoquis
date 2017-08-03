//
//  Gnoqui.swift
//  Gnoquis
//
//  Created by kino on 2/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import Foundation

struct Gnoqui {
    var id: Int
    var name: String
    var thumbnail: String
    var age : Int
    var weight : Double
    var height : Double
    var hair_color:  String
    var professions : [String]
    var friends : [String]

}

extension Gnoqui {
    
    init() {
        self.id = 0
        self.name = ""
        self.thumbnail = ""
        self.age = 0
        self.weight = 0.0
        self.height = 0.0
        self.hair_color = ""
        self.professions = [String]()
        self.friends = [String]()
        
    }
}
