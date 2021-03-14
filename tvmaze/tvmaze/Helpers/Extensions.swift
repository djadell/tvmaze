//
//  Extensions.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 14/03/2021.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func getImageWithUrl(urlString: String) {
        let cacheKey = urlString as NSString 
        image = nil
        if let imageFromCache = imageCache.object(forKey: cacheKey) as? UIImage {
            self.image = imageFromCache
            return
        }
        Service.shared.getImageWithUrl(urlString: urlString) { (image) in
            let imageToCache = image
            imageCache.setObject(imageToCache, forKey: cacheKey)
            self.image = imageToCache
        } failure: { (error) in
            print(error ?? "")
        }
    }
}
