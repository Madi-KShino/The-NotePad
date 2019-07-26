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
    func createNewUser(withEmail: String) {
        
    }
    
    //Find User
    func fetchUserWith(uuid: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    //Update User
    func update(user: User, email: String, firstName: String, lastName: String?) {
        
    }
    
    //Delete User
    func delete(user: User, completion: @escaping (Bool) -> Void) {
        
    }
}
