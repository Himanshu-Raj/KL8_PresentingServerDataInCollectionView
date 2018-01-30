//
//  Imgur.swift
//  PresentingServerDataInCollectionView
//
//  Created by Chaudhary Himanshu Raj on 30/01/18.
//  Copyright © 2018 Chaudhary Himanshu Raj. All rights reserved.
//

import Foundation

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
}
