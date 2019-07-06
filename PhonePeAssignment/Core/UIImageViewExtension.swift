//
//  UIImageViewExtension.swift
//  PhonePeAssignment
//
//  Created by Satyam Sehgal on 06/07/19.
//  Copyright © 2019 Satyam Sehgal. All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString, AnyObject>()

// Can make class also insteasd of imageview extension
extension UIImageView {
    
    func downloadFromLink(link: String, contentMode: UIView.ContentMode) {
        self.image = nil
        let imageURLString = link
        if let imageFromCache = imageCache.object(forKey: link as NSString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        guard let url = URL(string: link) else {
            // show placeholder image
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) -> Void in
            guard let data = data, error == nil else { return }
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.contentMode = contentMode
                let imageToCache = UIImage(data: data)
                if imageURLString == link {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: link as NSString)
            }
        }).resume()
    }
}
