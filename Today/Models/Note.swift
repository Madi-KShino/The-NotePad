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
    var noteUUID: String?
    var dictionary: [String : Any] {
        return [
            NoteConstants.timeStampKey : self.timeStamp,
            NoteConstants.titleKey : self.noteTitle,
            NoteConstants.textKey : self.noteText,
            NoteConstants.uuidKey : self.noteUUID!]
    }
    
    //Designated Init
    init(timeStamp: Date = Date(), noteTitle: String, noteText: String) {
        self.timeStamp = timeStamp
        self.noteTitle = noteTitle
        self.noteText = noteText
    }
}

//Audio Object
class Audio {
    var timeStamp: Date
    var fileName: String
    var audioUUID: String?
    var audioData: Data?
    var audioURL: URL?
    var dictionary: [String : Any] {
        return [
            AudioConstants.timeStampKey : self.timeStamp,
            AudioConstants.fileNameKey : self.fileName,
            AudioConstants.uuidKey : self.audioUUID!]
    }
    
    //Designated Init
    init(timeStamp: Date = Date(), fileName: String) {
        self.timeStamp = timeStamp
        self.fileName = fileName
    }
}

//Photo Object
class Photo {
    var timeStamp: Date
    var photoUUID: String?
    var photoData: Data?
    var photo: UIImage? {
        get {
            guard let photoData = photoData else { return nil }
            return UIImage(data: photoData)
        }
        set {
            photoData = newValue?.jpegData(compressionQuality: 0.5)
        }
    }
    var dictionary: [String : Any] {
        return [
            PhotoConstants.timeStampKey : self.timeStamp,
            PhotoConstants.uuidKey : self.photoUUID!]
    }
    
    //Designated Init
    init(timeStamp: Date = Date(), photo: UIImage) {
        self.timeStamp = timeStamp
        self.photo = photo
    }
}

//Firebase Convenience Initializer
extension Note {
    convenience init?(dictionary: [String : Any]) {
        guard let timeStamp = dictionary[NoteConstants.timeStampKey] as? Date,
            let noteTitle = dictionary[NoteConstants.titleKey] as? String,
            let noteText = dictionary[NoteConstants.textKey] as? String
            else { return nil }
        self.init(timeStamp: timeStamp, noteTitle: noteTitle, noteText: noteText)
    }
}

extension Audio {
    convenience init?(dictionary: [String : Any]) {
        guard let timeStamp = dictionary[AudioConstants.timeStampKey] as? Date,
        let fileName = dictionary[AudioConstants.fileNameKey] as? String
            else { return nil }
        self.init(timeStamp: timeStamp, fileName: fileName)
    }
}

extension Photo {
    convenience init?(dictionary: [String : Any]) {
        guard let timeStamp = dictionary[PhotoConstants.timeStampKey] as? Date,
            let photo = dictionary[PhotoConstants.photoKey] as? UIImage
            else { return nil }
        self.init(timeStamp: timeStamp, photo: photo)
    }
}

//Extensions So Objects Conform to Equatable
extension Note: Equatable {
   static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.noteUUID == rhs.noteUUID
    }
}

extension Audio: Equatable {
    static func == (lhs: Audio, rhs: Audio) -> Bool {
        return lhs.audioUUID == rhs.audioUUID
    }
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs:Photo) -> Bool {
        return lhs.photoUUID == rhs.photoUUID
    }
}

//Object Contstant Strings
struct NoteConstants {
    static let noteTypeKey = "Note"
    fileprivate static let timeStampKey = "timeStamp"
    fileprivate static let titleKey = "noteTitle"
    fileprivate static let textKey = "noteText"
    fileprivate static let uuidKey = "noteUUID"
}

struct AudioConstants {
    static let audioTypeKey = "Audio"
    fileprivate static let timeStampKey = "timeStamp"
    fileprivate static let fileNameKey = "fileName"
    fileprivate static let uuidKey = "audioUUID"
}

struct PhotoConstants {
    static let photoTypeKey = "Photo"
    fileprivate static let timeStampKey = "timeStamp"
    fileprivate static let uuidKey = "photoUUID"
    fileprivate static let photoKey = "photo"
}
