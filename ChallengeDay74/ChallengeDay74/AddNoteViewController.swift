//
//  AddNoteViewController.swift
//  ChallengeDay74
//
//  Created by BTSL.SAJID on 20/6/23.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Add Note"
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let newNote = Note(title: titleTextField.text ?? "", details: detailsTextView.text ?? "")
        dataSource.notes.append(newNote)
        dataSource.save()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil) //reload main table
    }
}
