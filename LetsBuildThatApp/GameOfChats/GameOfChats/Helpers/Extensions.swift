//
//  Extensions.swift
//  GameOfChats
//
//  Created by 강준영 on 18/12/2018.
//  Copyright © 2018 강준영. All rights reserved.
//

import UIKit

let cache = NSCache<NSString , UIImage>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(urlString: String) {
        
      //  self.image = nil
        
        //check chache for image first
        if let cacheImage = cache.object(forKey: urlString as NSString) {
            self.image = cacheImage
            return
        }
        
        //otherwise fire off a new download
        let profileImageURL = urlString
            if let url = URL(string: profileImageURL) {
                print(url)
                do {
                    let imageData = try Data(contentsOf: url)
                    if let downloadImage = UIImage(data: imageData) {
                        cache.setObject(downloadImage, forKey: urlString as NSString)
                        self.image = downloadImage
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
}


extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
