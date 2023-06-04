//
//  ViewController.swift
//  DemoCollectionView
//
//  Created by BTSL.SAJID on 4/6/23.
//
//
//import UIKit
//
//class ViewController: UIViewController {
//    @IBOutlet weak var collectionView: UICollectionView!
//
//    let names: [String] = ["Sajid", "Sami", "Rasheeq", "Maha"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//
//
//}
//
//extension ViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return names.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DummyCollectionViewCell", for: indexPath) as! DummyCollectionViewCell
//        cell.cellLabel.text = names[indexPath.row]
//        return cell
//    }
//}
//
//extension ViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let alert = UIAlertController(title: "Hi", message: "\(names[indexPath.row])", preferredStyle: .alert)
//        let action = UIAlertAction(title: "Ok", style: .default)
//        alert.addAction(action)
//        self.present(alert, animated: true)
//    }
//}
//
//class DummyCollectionViewCell: UICollectionViewCell {
//    @IBOutlet weak var cellLabel: UILabel!
//
//}

import UIKit

class ViewController: UIViewController {

    let nameArr = ["Ram" , "Shyam", "Joe", "Mark", "Richard", "Remo"]
    
    @IBOutlet weak var collView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DummyCollectionCell", for: indexPath) as! DummyCollectionCell
        cell.titleLabel.text = nameArr[indexPath.row]
        cell.userImageView.backgroundColor = .blue
        return cell
    }
    
}

extension ViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Hi", message: "\(nameArr[indexPath.row])", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
}

class DummyCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    
}
