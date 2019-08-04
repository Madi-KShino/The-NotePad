//
//  AddTodaysNoteViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/31/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class AddTodaysNoteViewController: UIViewController {

    //Source of Truth
    var photos: [Photo] = []
    var audioFiles: [Audio] = []
    var notes: [Note] = []
    
    //Outlets
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var notesButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        // Do any additional setup after loading the view.
        
    }

    func updateView() {
        photosButton.imageView?.image = photos.last?.photo
    }
}


