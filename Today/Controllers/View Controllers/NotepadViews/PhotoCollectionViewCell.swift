//
//  PhotoCollectionViewCell.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/1/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    //Properties
    var photo: Photo? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    //Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var timeStampLabel: UILabel!
    
    //Helper Function
    func updateViews() {
        guard let photo = photo else { return }
        photoImageView.image = photo.photo
        timeStampLabel.text = "\(photo.timeStamp)"
    }
}
