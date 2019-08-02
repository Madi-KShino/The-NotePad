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
        
    }
    
    func saveNewAudioFile(fileName: String, completion: @escaping (Audio?) -> Void) {
        
    }
    
    func saveNewPhoto(photo: UIImage, completion: @escaping (Photo?) -> Void) {
        
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
        
    }
    
    //Delete Objects
    func deleteNote(note: Note, completion: @escaping (Bool) -> Void) {
        
    }
    
    func deleteAudioFile(audioFile: Audio, completion: @escaping (Bool) -> Void) {
        
    }
    
    func deletePhoto(photo: Photo, completion: @escaping (Bool) -> Void) {
        
    }
}
