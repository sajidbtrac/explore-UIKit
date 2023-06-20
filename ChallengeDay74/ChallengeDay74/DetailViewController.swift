//
//  DetailViewController.swift
//  ChallengeDay74
//
//  Created by BTSL.SAJID on 20/6/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var noteDetailTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    var noteIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveButton.isHidden = true
        
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "xmark.bin"), style: .plain, target: self, action: #selector(deleteNote))
        deleteButton.tintColor = .red
        let composeButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeNote))
        
        navigationItem.rightBarButtonItems = [deleteButton, composeButton]
        
        let note = dataSource.notes[noteIndex]
        title = note.title
        noteDetailTextView.text = note.details
    }
    
    @objc func deleteNote() {
        dataSource.notes.remove(at: noteIndex)
        dataSource.save()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil) //reload main table
        navigationController?.popViewController(animated: true) // go back to previous view
    }
    
    @objc func composeNote() {
        print("compose")
        noteDetailTextView.isEditable = true
        saveButton.isHidden = false
    }
    
}
