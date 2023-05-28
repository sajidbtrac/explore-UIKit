//
//  ViewController.swift
//  Project1
//
//  Created by Sajid Shanta on 25/5/23.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)

        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        print(pictures)
    }
    
    // number of row in table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    // content of each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = pictures[indexPath.row]
        
        cell.contentConfiguration = content
        return cell
    }
}

