//
//  ViewController.swift
//  Project7
//
//  Created by BTSL.SAJID on 8/6/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions: [Petition] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(data: data)
            }
        }
    }
    
    func parse(data: Data) {
        let decoder = JSONDecoder()
        
        if let petitionsJSON = try? decoder.decode(Petitions.self, from: data) {
            petitions = petitionsJSON.results
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
}

