//
//  NoteDetailViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/3/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {

    //Properties
    var note: Note?
    
    //Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var saveNoteButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    
    //Actions
    //Save New Note or Update Existing Note
    @IBAction func saveNoteButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text,
            let text = noteTextView.text, !text.isEmpty
            else { return }
        if let note = note {
            NoteController.sharedInstance.updateNote(note: note, title: title, text: text)
            DispatchQueue.main.async {
                print("Note updated")
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            NoteController.sharedInstance.saveNewNote(title: title, text: text) { (note) in
                if note != nil {
                    DispatchQueue.main.async {
                        print("Note created")
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
    
    //Helper Functions
    func updateView() {
        guard let note = note else { return }
        titleTextField.text = note.noteTitle
        noteTextView.text = note.noteText
    }
}

extension NoteDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
}
