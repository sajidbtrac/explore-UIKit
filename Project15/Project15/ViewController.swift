//
//  ViewController.swift
//  Project15
//
//  Created by BTSL.SAJID on 15/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView!
    var currentAnimation = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }

    @IBAction func tapped(_ sender: Any) {
        currentAnimation += 1
        if currentAnimation > 0 { currentAnimation = 0}
    }
}

