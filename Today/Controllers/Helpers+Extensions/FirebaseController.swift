//
//  FirebaseController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/26/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import Foundation
import Firebase

class FirebaseController {
    
    //Shared Instance
    static let sharedInstance = FirebaseController()
    
    //Current User
    var currentUser = Auth.auth().currentUser
    var currentUserID: String?
    
    //Reference to Storage
    let storageReference = Storage.storage().reference()
    
    //Database URL (RT Database)
    let database = Database.database().reference(fromURL: "https://today-1564166996749.firebaseio.com/")
    
    //Authenticate User
    func authenticateUserWith(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            guard let userID = result?.user.uid else { completion(false); return }
            self.currentUserID = userID
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
    
    //Fetch Array of Dictionaries from Database (for User Data when retrieving an existing user)
    func fetchDictionary(type: String, uuid: String?, completion: @escaping ([[String : Any]]) -> Void) {
        if uuid != nil {
            //Fetch Object at Provided Path
            database.child(type).child(uuid!).observeSingleEvent(of: .value) { (dataSnapshot) in
                guard let dictionary = dataSnapshot.value as? [String : Any] else { return }
                completion([dictionary])
                return
            }
        } else {
            var foundDictionaries: [[String : Any]] = [[:]]
            database.child(type).observe(.childAdded) { (dataSnapshot) in
                guard let dictionary = dataSnapshot.value as? [String : Any] else { return }
                foundDictionaries.append(dictionary)
                completion(foundDictionaries)
            }
        }
    }
    
    //Create - Save New Object (as a UUID String) to Database
    func saveObjectToDatabase(uuid: String, type: String, withDictionary dictionary: [String : Any], completion: @escaping (Bool) -> Void) {
        //Url Path for Object to Save
        let reference = database.child(type).child(uuid)
        //Save the Dictionary for the Object
        reference.updateChildValues(dictionary) { (error, reference) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) \n---\n \(error)")
                completion(false)
                return
            }
            print("Saved object to Database")
            completion(true)
        }
    }
    
    //Update Object in Database
    func updateObjectOf(type: String, uuid: String, dictionary: [String : Any], completion: @escaping (Bool) -> Void) {
        database.child(type).child(uuid).updateChildValues(dictionary) { (error, reference) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(false)
                return
            }
            print("Successfully Updated Object Dictionary in Database")
            completion(true)
        }
    }
    
    //Delete Object from Database
    func deleteObjectWith(uuid: String, type: String, completion: @escaping (Bool) -> Void) {
        database.child(type).child(uuid).removeValue { (error, reference) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(false)
                return
            }
            print("Object Deleted Successfully")
            completion(true)
        }
    }
    
    //Save Image Data as URL to Database
    func uploadImage(type: String, uuid: String, data: Data, completion: @escaping (String?) -> Void) {
        //Reference to Storage
        let imageStoreReference = storageReference.child(type).child(uuid)
        //Put Data in the Storage Reference
        imageStoreReference.putData(data, metadata: nil) { (imageData, error) in
            if let error = error {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                completion(nil)
                return
            }
            //Get URL String from the Data
            imageStoreReference.downloadURL(completion: { (url, error) in
                if let error = error {
                    print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                    completion(nil)
                    return
                }
                if let url = url?.absoluteString {
                    completion(url)
                }
            })
        }
    }
    
    //Retrieve Image from URL String in Database
    func fetchImageFrom(url: String) -> UIImage? {
        var image: UIImage?
        do {
            guard let imageUrl = URL(string: url) else { return nil }
            let imageData = try Data(contentsOf: imageUrl)
            image = UIImage(data: imageData)
        } catch {
            print("Error Setting an Image from the Inage URL")
        }
        return image
    }
    
    //Save Audio Data as URL to Database
    
    //Retrieve Audio fron URL in Database
}
