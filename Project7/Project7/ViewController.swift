//
//  ViewController.swift
//  Project7
//
//  Created by BTSL.SAJID on 8/6/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "Title here"
        cell.detailTextLabel?.text = "Subtitle here"
        return cell
    }
}

