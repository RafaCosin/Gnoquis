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
        //dimensiones del imageView
        let cgSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
        print("*******cgSize : \(cgSize)")
       // Si la imagen ya está en cache, la recupera del diccionario
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            //si img.height > img.width -> crop a tamaño de imageView
            self.image = validateImg(img: cachedImage, imgViewSize: cgSize)
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
    //si la img a mostrar en ImageView img.Heigth > img.Width se recorta para dimensionarla

    func validateImg(img:UIImage, imgViewSize: CGSize)-> UIImage {

        if img.size.height > img.size.width {
            let coordIni = (img.size.height - img.size.width) / 4
            let origen = CGPoint(x: coordIni, y: coordIni)
            print("***************origen :\(origen)")
            let rect = CGRect(origin: origen, size: imgViewSize)
            print("***************rect :\(rect)")
            return crop(image: img, cropRect: rect)!
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

