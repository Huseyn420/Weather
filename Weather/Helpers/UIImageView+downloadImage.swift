//
//  UIImageView.swift
//  Weather
//
//  Created by Гусейн Агаев on 20.11.2020.
//

import UIKit

// MARK: - Private Properties

fileprivate let imageCache = NSCache<AnyObject, AnyObject>()

// MARK: - UIImageView
extension UIImageView {
    
    // MARK: - Public Method
    
    func loadImageUsingCache(urlString: String) {
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            DispatchQueue.main.async { () -> Void in
                self.image = cachedImage
            }
            
            return
        }
        
        downloadImage(urlString: urlString)
    }
    
    func downloadImage(urlString:String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard let data = data , error == nil, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async { () -> Void in
                self.image = image
                imageCache.setObject(image, forKey: urlString as AnyObject)
            }
        }).resume()
    }
}
