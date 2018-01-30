//
//  Imgur.swift
//  PresentingServerDataInCollectionView
//
//  Created by Chaudhary Himanshu Raj on 30/01/18.
//  Copyright © 2018 Chaudhary Himanshu Raj. All rights reserved.
//

import Foundation
import UIKit

struct Imgur {
    
    private let id : String
    private let imageURL : String
    let title : String
    // We will make this failable initializer, i.e. if we don't get any data we don't want it's object created.
    init?(json: JSON) {
        // Now we will check our json for the items we need.
        guard let id = json["id"] as? String,
                let title = json["title"] as? String,
                let imageURL = json["link"] as? String else { return nil }
        
        self.id = id
        self.title = title
        self.imageURL = imageURL
    }
    
    func getImage(completion : @escaping (UIImage) -> Void) {
        
        // Checking if image is already downloaded or not. If yes, we don't download it again. It not, proceed with downloading.
        if let image = imageCache.image(forKey: id) {
            completion(image)
        } else {
        NetworkingManager.shared.downloadImage(at: imageURL) { (success, downloadedImage, error) in
            
            if success {
                if let image = downloadedImage {
                    // Adding already downloaded image to image cache.
                    imageCache.add(image, forKey: self.id)
                    completion(image)
                } else {
                    print("Couldn't find image")
                }
            } else if let error = error {
                print("Error in View Did Load, Desc : \(error)")
            }
         }
       }
     }
}
