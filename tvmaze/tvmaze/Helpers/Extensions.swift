//
//  Extensions.swift
//  tvmaze
//
//  Created by David Adell Echevarria on 14/03/2021.
//

import UIKit

//MARK: - UIImageView
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

//MARK: - String
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
