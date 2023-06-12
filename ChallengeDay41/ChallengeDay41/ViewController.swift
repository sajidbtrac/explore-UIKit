//
//  ViewController.swift
//  ChallengeDay41
//
//  Created by BTSL.SAJID on 12/6/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var promptTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var turnLeftLabel: UILabel!
    @IBOutlet weak var turnLeftProgressView: UIProgressView!

    var word = "RHYTHM".uppercased()
    var usedLetters: [String] = []
    var turn = 0 {
        didSet {
            turnLeftLabel.text = "Turn left: \(7-turn)"
            turnLeftProgressView.setProgress(Float(turn)/7, animated: true)
            
            if turn >= 7 {
                let ac = UIAlertController(title: "Your turn is over!", message: "Try again..", preferredStyle: .alert)
                let tryAgainAction = UIAlertAction(title: "Restart", style: .default) {_ in
                    self.restart()
                }
                ac.addAction(tryAgainAction)
                present(ac, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Guess the Word"
        displayWord()
        turnLeftLabel.text = "Turn left: 0"
        turnLeftProgressView.progress = 0
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if let promptWord = promptTextField.text?.uppercased() {
            if word.contains(promptWord) {
                usedLetters.append(promptWord)
                displayWord()

                if word == wordLabel.text {
                    let ac = UIAlertController(title: "Congratulation!", message: "You just guess the word right", preferredStyle: .alert)
                    let playAgainAction = UIAlertAction(title: "Play Again", style: .default) {_ in
                        self.restart()
                    }
                    ac.addAction(playAgainAction)
                    present(ac, animated: true)
                }
            }
        }
        
        promptTextField.text = ""
        turn += 1
    }

    func displayWord() {
        var wordArrray = Array(word)
        var labelTextArray = [String](repeating: "_", count: wordArrray.count)
        
        for i in 0..<word.count {
            for  usedLetter in usedLetters {
                if String(wordArrray[i]) == usedLetter {
                    labelTextArray[i] = usedLetter
                }
            }
        }
        wordLabel.text = labelTextArray.joined()
    }
    
    func restart() {
        self.turn = 0
        self.word = "BOOM"
        usedLetters.removeAll(keepingCapacity: true)
        self.displayWord()
    }
}
