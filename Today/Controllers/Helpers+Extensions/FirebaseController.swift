//
//  FirebaseController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/26/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import Firebase
//AIzaSyAx2olnInuFdN_lAjD8CjSIwGbeknHe1Ww

class FirebaseController {
    
    //Shared Instance
    static let sharedInstance = FirebaseController()
    
    //Current User
    var currentUser = Auth.auth().currentUser
    
    //Reference to Storage
    let storage = Storage.storage().reference()
    
    //Database URL (RT Database)
    let database = Database.database().reference(fromURL: "https://today-1564166996749.firebaseio.com/")
    
    //Authenticate User
    func authenticateUserWith(email: String, password: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(false)
                return
            }
            guard let userID = result?.user.uid else { completion(false); return }
            self.currentUser = result?.user
            print("User (with ID: \(userID)) Authenticated Successfully")
            completion(true)
        }
    }
    
    //Sign User Out
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
        }
    }
    
    //Create - Save New Object (as a UUID String) to Database
    func saveToDatabase(object: String, type: String, withDictionary dictionary: [String : Any], completion: @escaping (Bool) -> Void) {
        //Url Path for Object to Save
        let reference = database.child(type).child(object)
        //Save the Dictionary for the Object
        reference.updateChildValues(dictionary) { (error, reference) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(false)
                return
            }
            print("Saved object to Database")
            completion(true)
        }
    }
    
    
}
