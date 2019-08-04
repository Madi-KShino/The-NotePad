//
//  NoteListTableViewCell.swift
//  Today
//
//  Created by Madison Kaori Shino on 8/3/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {

    //Properties
    var note: Note? {
        didSet {
            updateView()
        }
    }
    
    //Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteTextLabel: UILabel!
    
    //Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateView() {
        guard let note = note else { return }
        dateLabel.text = "\(note.timeStamp)"
        titleLabel.text = note.noteTitle
        noteTextLabel.text = note.noteText
    }

}
