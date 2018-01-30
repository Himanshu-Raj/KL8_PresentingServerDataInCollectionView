//
//  ImgurCell.swift
//  PresentingServerDataInCollectionView
//
//  Created by Chaudhary Himanshu Raj on 29/01/18.
//  Copyright © 2018 Chaudhary Himanshu Raj. All rights reserved.
//

import UIKit

class ImgurCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageLabel: UILabel!
    
    func configure(with imgur : Imgur) {
        imageLabel.text = imgur.title
    }
}
