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
        
        DispatchQueue.global().sync {
        imgur.getImage(completion: { (finalImage) in
            self.imageView.image = finalImage
        })
      }
    }
    
    override func prepareForReuse() {
        imageLabel.text = nil
        imageView.image = nil
    }
}

/*
 IMPORTANT NOTE : 
    While we are dealing a large chunk of data containing images and label to be displayed, there will be some problems. Some of them are :
    1.)    Adjacent images could appear to be same or in one screen multiple same images appear while they are not supposed to be so.
    2.)    As we scroll up and down, the images once downloaded and appeared also seems to be changing.
 
 CAUSE :
        We are using dequeReusableCell, so what's happening is when we are our collection view is reusing a cell, there was already an image value and label value set/populated for that cell. But when we scroll, it will have to again process to go and download next data and again update in the cells. So, to tackle this situation, we need to prepare our cells for reusability.
 
 SOLUTION :
    1.)     Though to manage reusability of cells we have called DequeReusableCell but still above mentioned problems arrives.
            So, override a function from UICollectionViewCell and in it set, label value and image value to nil. This will solve the flickering the issue.
    2.)     CACHING IMAGES : In the above mentioned problems, what's happenig is our images are being downloaded and redownloaded, every time screen is scrolled. Thus, we can download once and cache those images. Doing so, our images will be available locally and hence this will finish the overhead of downloading and redownloading images.
*/
