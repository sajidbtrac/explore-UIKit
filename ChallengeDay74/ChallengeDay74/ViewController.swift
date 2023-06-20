//
//  ViewController.swift
//  ChallengeDay74
//
//  Created by BTSL.SAJID on 20/6/23.
//

import UIKit

class dataSource {
    let defaults = UserDefaults.standard

    static var notes: [Note] = []
    
    static func save() {
        let jsonEncoder = JSONEncoder()
        
        if let savedData = try? jsonEncoder.encode(dataSource.notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
            
        } else {
            print("Failed to save people!")
        }
    }
}

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Quick Notes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        
        let defaults = UserDefaults.standard
        if let savedNotes = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                dataSource.notes = try jsonDecoder.decode([Note].self, from: savedNotes)
            } catch {
                print("Faield to load data")
            }
        }
                
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
     
    @objc func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }
    
    @objc func addNote() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AddNote") as? AddNoteViewController {

            // for bottom sheet
            if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.largestUndimmedDetentIdentifier = .medium
                sheet.prefersGrabberVisible = true
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
            
            present(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = dataSource.notes[indexPath.row].title
        
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetail") as? DetailViewController {
            vc.noteIndex = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
