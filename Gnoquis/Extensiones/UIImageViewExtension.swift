//
//  UIImageViewExtension.swift
//  Gnoquis
//
//  Created by kino on 3/08/2017.
//  Copyright © 2017 Rafa Cosin. All rights reserved.
//

import UIKit

//dictionary cache para guardar imagenes download
let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
       // Si la imagen ya está en cache, la recupera del diccionario
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            //si img.height > img.width -> crop a tamaño de imageView
            self.image = validateImg(img: cachedImage)
            return
        }
        
        // si no está en diccionario download image desde la url
        //
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
         // interface se refresca en el main trehad
         // se guarda imagen en diccionario cache
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }
    func validateImg(img:UIImage)-> UIImage {
        let size = CGSize(width: 343, height: 260)
        let origen = CGPoint(x: 45, y: 45)
        let rect = CGRect(origin: origen, size: size)
        var newImg = UIImage()
        
        if img.size.height > img.size.width {
            newImg = crop(image: img, cropRect: rect)!
            return newImg
        }
        return img
    }
    func crop(image:UIImage, cropRect:CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(cropRect.size, false, image.scale)
        let origin = CGPoint(x: cropRect.origin.x * CGFloat(-1), y: cropRect.origin.y * CGFloat(-1))
        image.draw(at: origin)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return result
    }
    
}

