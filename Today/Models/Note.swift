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

//Notepad Object
class Notepad{
    
    var timeStamp: Date
    var notes: [Note]
    var photos: [Photo]
    var audioFiles: [Audio]
    
    //Designated Init
    init(timeStamp: Date = Date(), notes: [Note] = [], photos: [Photo] = [], audioFiles: [Audio] = []) {
        self.timeStamp = timeStamp
        self.notes = notes
        self.photos = photos
        self.audioFiles = audioFiles
    }
}

//Note Object (of Notepad)
class Note {
    var timeStamp: Date
    var noteText: String
    
    //Designated Init
    init(timeStamp: Date = Date(), noteText: String) {
        self.timeStamp = timeStamp
        self.noteText = noteText
    }
}

//Photo Object (of Notepad)
class Photo {
    var timeStamp: Date
    var photo: UIImage
    
    //Designated Init
    init(timeStamp: Date = Date(), photo: UIImage) {
        self.timeStamp = timeStamp
        self.photo = photo
    }
}

//Audio Object (of Notepad)
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
