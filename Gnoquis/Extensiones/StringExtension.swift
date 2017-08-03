//
//  StringExtension.swift
//  Gnoquis
//
//  Created by kino on 3/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit
func changeParticleString(urlString : String, particleIn: String, particleOut: String)-> String{
    
    return (urlString.replacingOccurrences(of: particleIn, with: particleOut))
//    let aString = urlString
//    let newString = aString.replacingOccurrences(of: "http:", with: "https:")
//    return newString
}
