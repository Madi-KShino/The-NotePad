//
//  Note.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/25/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class Note {
    
    var timeStamp: Date
    var noteText: String?
    var photo: UIImage?
    var audio: AVAudioFile?
    
    init(timeStamp: Date = Date(), noteText: String?, photo: UIImage?, audio: AVAudioFile?) {
        self.timeStamp = timeStamp
        self.noteText = noteText
        self.photo = photo
        self.audio = audio
    }
}
