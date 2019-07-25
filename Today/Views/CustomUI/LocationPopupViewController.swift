//
//  LocationPopupViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/25/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class LocationPopupViewController: UIViewController {

    @IBOutlet weak var selectLocationLabel: UILabel!
    @IBOutlet weak var locationPickerView: UIPickerView!
    @IBOutlet weak var loctionSelectedButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func locationSelectedButtonTapped(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    
}
