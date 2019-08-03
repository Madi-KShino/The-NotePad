//
//  NoteController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/25/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class NoteController {
    
    //Singleton
    static let sharedInstance = NoteController()
    
    //Source of Truth
    var notes: [Note] = []
    var audioFiles: [Audio] = []
    var photos: [Photo] = []
    
    //Create New Objects
    func saveNewNote(title: String, text: String, completion: @escaping (Note?) -> Void) {
        let newNote = Note(noteTitle: title, noteText: text)
        let uuid = newNote.noteUUID
        FirebaseController.sharedInstance.saveObjectToDatabase(uuid: uuid, type: NoteConstants.noteTypeKey, withDictionary: newNote.dictionary) { (success) in
            if success {
                print("Successfully Saved Item With ID: \(uuid) to Database")
                self.notes.append(newNote)
                UserController.sharedInstance.currentUser?.noteUuids.append(newNote.noteUUID)
            }
        }
    }
    
    func saveNewAudioFile(fileName: String, completion: @escaping (Audio?) -> Void) {
        let newAudio = Audio(fileName: fileName)
        let uuid = newAudio.audioUUID
        FirebaseController.sharedInstance.saveObjectToDatabase(uuid: uuid, type: AudioConstants.audioTypeKey, withDictionary: newAudio.dictionary) { (success) in
            if success {
                 print("Successfully Saved Item With ID: \(uuid) to Database")
                self.audioFiles.append(newAudio)
                UserController.sharedInstance.currentUser?.audioUuids.append(newAudio.audioUUID)
            }
        }
    }
    
    func saveNewPhoto(photo: UIImage, completion: @escaping (Photo?) -> Void) {
        let newPhoto = Photo(photo: photo)
        let uuid = newPhoto.photoUUID
        guard let data = newPhoto.photoData else { return }
        FirebaseController.sharedInstance.uploadImage(type: PhotoConstants.photoTypeKey, uuid: uuid, data: data) { (url) in
            let uuid = UserController.sharedInstance.currentUser?.uuid
        }
    }
    
    //Fetch Objects
    func fetchNotes(completion: @escaping ([Note]?) -> Void) {
        
    }
    
    func fetchAudioFiles(completion: @escaping ([Audio]?) -> Void) {
        
    }
    
    func fetchPhotos(completion: @escaping ([Photo]?) -> Void) {
        
    }
    
    //Update Existing Objects
    func updateNote(note: Note, title: String, text: String) {
        note.noteTitle = title
        note.noteText = text
    }
    
    //Delete Objects
    func deleteNote(note: Note, completion: @escaping (Bool) -> Void) {
        
    }
    
    func deleteAudioFile(audioFile: Audio, completion: @escaping (Bool) -> Void) {
        
    }
    
    func deletePhoto(photo: Photo, completion: @escaping (Bool) -> Void) {
        
    }
}
