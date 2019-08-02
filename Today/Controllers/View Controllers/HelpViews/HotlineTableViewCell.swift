//
//  HotlineTableViewCell.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/28/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class HotlineTableViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var textNumberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    //Properties
    var hotline: Hotline? {
        didSet {
            self.updateViews()
        }
    }
    
    //Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
//        setUpUI()
    }
    
    //Helper Functions
    func updateViews() {
        guard let hotline = hotline else { return }
        nameLabel.text = hotline.name
        if hotline.number == nil {
            numberLabel.isHidden = true
        } else {
            numberLabel.isHidden = false
            numberLabel.text = hotline.number
        }
        if hotline.textNumber == nil {
            textNumberLabel.isHidden = true
        } else {
            textNumberLabel.isHidden = false
            textNumberLabel.text = hotline.textNumber
        }
        if hotline.website == nil {
            websiteLabel.isHidden = true
        } else {
            websiteLabel.isHidden = false
            websiteLabel.text = hotline.website
        }
    }
    
    func setUpUI() {
    }
}
