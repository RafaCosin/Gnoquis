//
//  FuncHelpers.swift
//  Gnoquis
//
//  Created by kino on 3/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

func data_request(urlString : String) -> UIImage?
{
    
    var image: UIImage?
    let aString = urlString
    let newString = aString.replacingOccurrences(of: "http:", with: "https:")
    
    //   let request = URLRequest(url: URL(string: gnomesURL)!)
    let urltxt = URL(string:newString)
    let request = URLRequest(url: urltxt!)
    
    print(request)
    let urlSession = URLSession.shared
    DispatchQueue.global().async {
    let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
        //            if let response = response {
        //                print(response)
        //                return
        //            }
        if let error = error {
            print(error)
            return
        }
        
        // Parse JSON data
        
        if let data = data {
            image = UIImage(data: data)
            
        }
        
    })
    
    
    task.resume()
    }
    return image
    
}
func changeHttps(urlString : String)-> String{
    
        let aString = urlString
        let newString = aString.replacingOccurrences(of: "http:", with: "https:")
        return newString
}


