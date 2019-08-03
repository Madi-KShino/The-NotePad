//
//  User.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/25/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

//User Object Class Declaration
class User {
    
    //Class Properties
    var email: String
    var firstName: String
    var noteUuids: [String] = []
    var audioUuids: [String] = []
    var photoUuids: [String] = []
    //Firebase Properties
    var uuid: String?
    var dictionary: [String : Any] {
        return [
            UserConstants.emailKey : self.email,
            UserConstants.firstNameKey : self.firstName,
            UserConstants.uuidKey : self.uuid!,
            UserConstants.notesKey : self.noteUuids,
            UserConstants.audioKey : self.audioUuids,
            UserConstants.photoKey : self.photoUuids
        ]
    }
    
    //Designated/Memberwise Initializer
    init(email: String, firstName: String) {
        self.email = email
        self.firstName = firstName
    }
}

//Firebase Convenience Initializer
extension User {
    convenience init?(dictionary: [String : Any]) {
        guard let email = dictionary[UserConstants.emailKey] as? String,
        let firstName = dictionary[UserConstants.firstNameKey] as? String
//        let notes = dictionary[UserConstants.notesKey] as? [String],
//        let audio = dictionary[UserConstants.audioKey] as? [String],
//        let photos = dictionary[UserConstants.photoKey] as? [String]
            else { return nil }
//        self.init(email: email, firstName: firstName, notes: notes, audio: audio, photos: photos)
        self.init(email: email, firstName: firstName)
    }
}

//Equatable Protocol on User Class
extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}

//User Key Magic Strings
struct UserConstants {
    static let userTypeKey = "User"
    fileprivate static let emailKey = "email"
    fileprivate static let firstNameKey = "firstName"
    fileprivate static let uuidKey = "uuid"
    fileprivate static let notesKey = "noteUuids"
    fileprivate static let audioKey = "audioUuids"
    fileprivate static let photoKey = "photoUuids"
}
