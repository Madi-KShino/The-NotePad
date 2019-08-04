//
//  PhotoPopupViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/1/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class PhotoPopupViewController: UIViewController {

    //Landing Pad
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    //Outlets
    @IBOutlet weak var photoView: UIImageView!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Helper Function
    func updateViews() {
        guard let photo = photo else { return }
        photoView.image = photo.photo
    }

}
