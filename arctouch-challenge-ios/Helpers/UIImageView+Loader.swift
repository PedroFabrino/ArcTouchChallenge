//
//  UIImageView+Loader.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 12/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    
    func loadImage(url: URL?, placeholder: UIImage? = nil, showActivityIndicator: Bool = false) {
        guard let url = url else {
            return
        }
        self.sd_setShowActivityIndicatorView(showActivityIndicator)
        self.sd_setIndicatorStyle(.white)
        
        if let key = SDWebImageManager.shared().cacheKey(for: url), let image = SDWebImageManager.shared().imageCache?.imageFromCache(forKey: key) {
            self.image = image
        } else {
            self.sd_setImage(with: url, placeholderImage: placeholder)
        }
    }
    
    func loadImage(url: URL?, placeholder: UIImage? = nil, showActivityIndicator: Bool = false, completion: @escaping(_ image: UIImage?) -> Void) {
        guard let url = url else {
            return
        }
        self.sd_setShowActivityIndicatorView(showActivityIndicator)
        self.sd_setIndicatorStyle(.white)
        
        if let key = SDWebImageManager.shared().cacheKey(for: url), let image = SDWebImageManager.shared().imageCache?.imageFromCache(forKey: key) {
            self.image = image
            completion(image)
        } else {
            self.sd_setImage(with: url, placeholderImage: placeholder) { (image, _, _, _) in
                completion(image)
            }
        }
        
    }
    
    func loadImage(urlString: String?, placeholder: UIImage? = nil, showActivityIndicator: Bool = false) {
        loadImage(url: URL(string: urlString ?? ""), placeholder: placeholder, showActivityIndicator: showActivityIndicator)
    }
    
    func cancelLoad() {
        self.sd_cancelCurrentImageLoad()
    }

    func addActivityIndicator() {
        self.sd_addActivityIndicator()
    }
    
    func removeActivityIndicator() {
        self.sd_removeActivityIndicator()
    }
}