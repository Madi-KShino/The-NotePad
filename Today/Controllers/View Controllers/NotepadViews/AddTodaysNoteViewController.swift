//
//  AddTodaysNoteViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/31/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class AddTodaysNoteViewController: UIViewController {

    var photos: [Photo] = []
    var audioFiles: [Audio] = []
    var notes: [Note] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func updateView() {

    }
}

extension AddTodaysNoteViewController: PhotoSelectorViewControllerDelegate {
    func photoSelectorViewControllerSelected(image: UIImage) {
        let newImage = Photo(photo: image)
        //save to Notepad in Firebase
        photos.append(newImage)
    }
}
