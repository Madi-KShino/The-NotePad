//
//  UserController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/25/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class UserController {
    
    //Singleton
    static let sharedInstance = UserController()
    
    //Source of Truth
    var currentUser: User?
    
    //Create a User
    func createNewUser(withEmail email: String, firstName: String) {
        guard let uuid = FirebaseController.sharedInstance.currentUser?.uid else { return }
        let newUser = User(email: email, firstName: firstName)
        newUser.uuid = uuid
        FirebaseController.sharedInstance.saveObjectToDatabase(object: uuid, type: UserConstants.userTypeKey, withDictionary: newUser.dictionary) { (success) in
            if success {
                print("User (with ID: \(uuid)) Successfully Saved")
                self.currentUser = newUser
            }
        }
    }
    
    //Find User
    func fetchUserWith(uuid: String, completion: @escaping (Bool) -> Void) {
        FirebaseController.sharedInstance.fetchDictionary(type: UserConstants.userTypeKey, uuid: uuid) { (dictionaries) in
            guard let userDictionary = dictionaries.first else { return }
            let fetchedUser = User(dictionary: userDictionary)
            self.currentUser = fetchedUser
        }
    }
    
    //Update User
    func update(user: User, email: String, firstName: String, lastName: String?) {
        user.email = email
        user.firstName = firstName
        user.lastName = lastName
        guard let uuid = user.uuid else { return }
        FirebaseController.sharedInstance.updateObjectOf(type: UserConstants.userTypeKey, uuid: uuid, dictionary: user.dictionary) { (success) in
            if success {
                //Handle
            }
        }
    }
    
    //Delete User
    func delete(user: User, completion: @escaping (Bool) -> Void) {
        guard let uuid = user.uuid else { return }
        FirebaseController.sharedInstance.deleteObjectWith(uuid: uuid, type: UserConstants.userTypeKey) { (success) in
            if success {
                //Handle
            }
        }
    }
}
