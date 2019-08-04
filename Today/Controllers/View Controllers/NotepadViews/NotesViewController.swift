//
//  NotesViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/3/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {

    //Properties
    var notes: [Note] = []
    
    
    //Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var noteListTableView: UITableView!
    @IBOutlet weak var newNoteButton: UIButton!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteListTableViewCell else { return UITableViewCell() }
        let note = notes[indexPath.row]
        cell.note = note
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNoteDetailViewController" {
            guard let index = noteListTableView.indexPathForSelectedRow,
                let destination = segue.destination as? NoteDetailViewController
                else { return }
            let note = notes[index.row]
            destination.note = note
        }
    }
}
