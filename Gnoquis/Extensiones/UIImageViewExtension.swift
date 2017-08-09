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

        self.image = nil
        //dimensiones del imageView
        let cgSize = CGSize(width: self.frame.size.width, height: self.frame.size.height)
       // Si la imagen ya está en cache, la recupera del diccionario
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            
            //si img.height > img.width -> crop a tamaño de imageView
            self.image = validateImg(img: cachedImage, imgViewSize: cgSize)
            return
        }
        if let url = URL(string: urlString)  {
        // si no está en diccionario download image desde la url
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                DispatchQueue.main.async {
                    self.image = UIImage(named:"duende_molon")
            }
            return
        }
         // interface se refresca en el main trehad
            DispatchQueue.main.async {
                if let data = data {
                    if let image = UIImage(data: data) {
                        let iconoImg = self.validateImg(img: image, imgViewSize: cgSize)
                        self.image = iconoImg
                        //Se guarda imagen en diccionario cache
                        imageCache.setObject(image, forKey: urlString as NSString)
                    }
                }
            }
          }).resume()
        }
    }
    
    //si la img a mostrar en ImageView img.Heigth > img.Width se recorta para dimensionarla

    func validateImg(img:UIImage, imgViewSize: CGSize)-> UIImage {
        var imgViewSize = imgViewSize
        let coordIni = (img.size.height - img.size.width) / 4
        let origen = CGPoint(x: coordIni, y: coordIni)
            
        if img.size.height > img.size.width {

//            //para avatar se corrige tamaño recorte y  la posicion inicial para
//            //las fotos descentrada. Es una chapuza total
            if imgViewSize.width < 80.0 {
                imgViewSize.width = img.size.width/2
                imgViewSize.height = img.size.height/2
                //origen.x += 30.0
               // origen.y -= 40.0
            }
            let rect = CGRect(origin: origen, size: imgViewSize)
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

