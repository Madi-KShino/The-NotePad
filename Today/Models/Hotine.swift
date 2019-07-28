//
//  Hotine.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/25/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation

class Hotline {

    var name: String
    var number: String?
    var textNumber: String?
    var website: String?
    
    init(name: String, number: String?, textNumber: String?, website: String?) {
        self.name = name
        self.number = number
        self.textNumber = textNumber
        self.website = website
    }
}

