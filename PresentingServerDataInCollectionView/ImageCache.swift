//
//  ImageCache.swift
//  PresentingServerDataInCollectionView
//
//  Created by Chaudhary Himanshu Raj on 30/01/18.
//  Copyright © 2018 Chaudhary Himanshu Raj. All rights reserved.
//

import Foundation
import UIKit

class ImageCache : NSCache<AnyObject, AnyObject> {
    
    func add(_ image: UIImage, forKey key: String) {
        setObject(image, forKey: key as AnyObject)
    }
    
    func image(forKey key: String) -> UIImage? {
        guard let image = object(forKey: key as AnyObject) as? UIImage else { return nil }
        return image
    }
}
