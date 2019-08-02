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

//Note Object
class Note {
    var timeStamp: Date
    var noteTitle: String
    var noteText: String
    
    //Designated Init
    init(timeStamp: Date = Date(), noteText: String) {
        self.timeStamp = timeStamp
        self.noteText = noteText
    }
}

//Photo Object
class Photo {
    var timeStamp: Date
    var photo: UIImage
    
    //Designated Init
    init(timeStamp: Date = Date(), photo: UIImage) {
        self.timeStamp = timeStamp
        self.photo = photo
    }
}

//Audio Object
class Audio {
    var timeStamp: Date
    var audioRecording: URL
    var fileName: String
    
    //Designated Init
    init(timeStamp: Date = Date(), audioRecording: URL, fileName: String) {
        self.timeStamp = timeStamp
        self.audioRecording = audioRecording
        self.fileName = fileName
    }
}

struct NoteConstants {
    static let noteTypeKey = "Note"
    fileprivate static let timeStampKey = "timeStamp"
    fileprivate static let titleKey = "noteTitle"
    fileprivate static let textKey = "noteText"
}
