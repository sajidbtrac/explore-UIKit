//
//  ViewController.swift
//  ChallengeDay32
//
//  Created by BTSL.SAJID on 8/6/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var shopingList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(clearShopingList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptToAddShopingItem))
        
        title = "Shoping Cart"
    }
    
    @objc func clearShopingList() {
        shopingList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    @objc func promptToAddShopingItem() {
        let ac = UIAlertController(title: "Add Shoping Item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let addItemAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.shopingList.insert(item, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
        }
        ac.addAction(addItemAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
}

//MARK: configure table
extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "shoppingItem")
        cell.textLabel?.text = shopingList[indexPath.row]
        return cell
    }
}
