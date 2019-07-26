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
    var lastName: String?
    
    //Firebase Properties
    var uuid: String?
    var dictionary: [String : Any] {
        return [
            UserConstants.emailKey : self.email,
            UserConstants.firstNameKey : self.firstName,
            UserConstants.lastNameKey : self.lastName ?? "",
            UserConstants.uuidKey : self.uuid!
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
            else { return nil }
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
    fileprivate static let lastNameKey = "lastName"
    fileprivate static let uuidKey = "uuid"
}
