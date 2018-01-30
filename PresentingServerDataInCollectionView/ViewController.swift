//
//  ViewController.swift
//  PresentingServerDataInCollectionView
//
//  Created by Chaudhary Himanshu Raj on 29/01/18.
//  Copyright © 2018 Chaudhary Himanshu Raj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var imgurs = [Imgur]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkingManager.shared.getImgurs { (success, imgurResponse, error) in
            if success {
                // print("Pheww...!! Made it to ViewDidLoad")
                // print("Imgur Response : \(imgurResponse?.imgurs)")
                self.imgurs = (imgurResponse?.imgurs)!
                self.collectionView.reloadData()
            } else if let error = error {
                print("Error in View Did Load, Desc : \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgurs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgurCell", for: indexPath) as? ImgurCell else { return UICollectionViewCell() }
        cell.configure(with : imgurs[indexPath.row])
        return cell
    }
}
