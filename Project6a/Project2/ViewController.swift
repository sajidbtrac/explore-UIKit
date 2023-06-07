//
//  ViewController.swift
//  Project2
//
//  Created by BTSL.SAJID on 31/5/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var askedQuestions = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        
        button2.layer.borderWidth = 1
        button2.layer.borderColor = UIColor.lightGray.cgColor

        button3.layer.borderWidth = 1
        button3.layer.borderColor = UIColor.lightGray.cgColor

        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        askedQuestions += 1
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        title = "Tap on \(countries[correctAnswer].uppercased())'s Flag. Your Score: \(score)"
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
        } else {
            title = "Wrong! That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        if askedQuestions < 10 {
            let ac = UIAlertController(title: title, message: "Your score is: \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
        } else {
            let finalAC = UIAlertController(title: "Game Over!", message: "Your score is: \(score)", preferredStyle: .alert)
            finalAC.addAction(UIAlertAction(title: "Play Again", style: .default, handler: startGame))
            present(finalAC, animated: true)
        }
    }
    
    func startGame(action: UIAlertAction! = nil) {
        score = 0
        askedQuestions = 0
        askQuestion()
    }
}

