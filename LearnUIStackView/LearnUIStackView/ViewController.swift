//
//  ViewController.swift
//  LearnUIStackView
//
//  Created by BTSL.SAJID on 5/6/23.
//

import UIKit
//import Reusable

class ViewController: UIViewController {
    @IBOutlet weak var myStack: UIStackView!
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l5: UILabel!
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var mySwitch: UISwitch!
    
    let animals: [String] = ["Horse", "Cow", "Camel", "Sheep", "Goat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        l1.text = "snta"

        tableView.register(DemoTableCell.self, forCellReuseIdentifier: "DemoTableCell")
    }
    
    @IBAction func mySwitchAction(_ sender: UISwitch) {
        if sender.isOn {
            UIView.animate(withDuration: 0.5) {
                self.myStack.subviews[2].alpha = 0
                self.myStack.subviews[2].isHidden = true
                self.view.layoutSubviews()
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.myStack.subviews[2].alpha = 1
                self.myStack.subviews[2].isHidden = false
                self.view.layoutSubviews()
            }
        }
    }
}

class DemoTableCell: UITableViewCell {
    @IBOutlet weak var demoLabel: UILabel!

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DemoTableCell = tableView.dequeueReusableCell(withIdentifier: "DemoTableCell", for: indexPath) as! DemoTableCell

        cell.demoLabel.text = animals[indexPath.row]
        
        let estimatedHeight = tableView.numberOfRows(inSection: 0) //You may need to modify as necessary
        let width = myStack.frame.size.width
        tableView.frame = CGRect(x: 0, y: 0, width: Int(width), height: estimatedHeight)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        contactList[indexPath.row].isSelected.toggle()
//        updateUI()
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
