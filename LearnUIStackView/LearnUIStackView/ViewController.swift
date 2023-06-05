//
//  ViewController.swift
//  LearnUIStackView
//
//  Created by BTSL.SAJID on 5/6/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var myStack: UIStackView!
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var l4: UILabel!
    @IBOutlet weak var l5: UILabel!
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

