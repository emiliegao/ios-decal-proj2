//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var hangmanImage: UIImageView!
    
    @IBOutlet weak var guessStatus: UILabel!
    
    @IBOutlet weak var inputTextField: UITextField!
    
    @IBOutlet weak var incorrectGuessLabel: UILabel!
    
    var phraseGuess:String = ""
    
    var incorrectChars:[String] = [""]
    
    var incorrectGuessString:String = "Incorrect Guesses: "
    
    var incorrectCount = 0
    
    var keyPhrase:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        
        keyPhrase = phrase
        
        hangmanImage.image = UIImage(named: "hangman1.gif")
        
        for i in phrase.characters.indices {
            if (phrase[i] == " ") {
                phraseGuess += " "
            } else {
                phraseGuess += "_"
            }
        }
        
        guessStatus.text = phraseGuess

        
        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func guessButtonPressed(sender: AnyObject) {
        //error checking
        var error = false
        if (inputTextField.text?.characters.count < 1) {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "No inputted characters"
            alert.addButtonWithTitle("OK")
            alert.show()
            
            inputTextField.text = ""
            error = true
        } else if (inputTextField.text?.characters.count > 1) {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "Too many characters"
            alert.addButtonWithTitle("OK")
            alert.show()
            
            inputTextField.text = ""
            error = true
        } else {
            let isChar = containsOnlyLetters(inputTextField.text!)
            if (!isChar) {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "Guess must be an alphabetical character"
                alert.addButtonWithTitle("OK")
                inputTextField.text = ""
                error = true
            }
        }
        
        if (error == false) {
            var contains = false
            
            for i in guessStatus.text!.characters.indices {
                if (String(i) == inputTextField.text) {
                    contains = true
                }
            }
            
            if (contains == true) {
                var currGuess = guessStatus.text
                if (currGuess!.characters.last == " ") {
                    currGuess = String(currGuess!.characters.dropLast())
                    currGuess = String(currGuess!.characters.dropLast())
                } else {
                    currGuess = String(currGuess!.characters.dropLast())
            }
            
            inputTextField.text = ""
            guessStatus.text = currGuess
            } else {
                incorrectChars[0] = (inputTextField.text!)
                inputTextField.text = ""
                
                
                incorrectCount++
                if (incorrectCount == 0) {
                    hangmanImage.image = UIImage(named: "hangman1.gif")
                } else if (incorrectCount == 1) {
                    hangmanImage.image = UIImage(named: "hangman2.gif")
                } else if (incorrectCount == 2) {
                    hangmanImage.image = UIImage(named: "hangman3.gif")
                } else if (incorrectCount == 3) {
                    hangmanImage.image = UIImage(named: "hangman4.gif")
                } else if (incorrectCount == 4) {
                    hangmanImage.image = UIImage(named: "hangman5.gif")
                } else if (incorrectCount == 5) {
                    hangmanImage.image = UIImage(named: "hangman6.gif")
                } else if (incorrectCount == 6) {
                    hangmanImage.image = UIImage(named: "hangman7.gif")
                    //END THE GAME
                }
            
                for i in incorrectChars {
                    incorrectGuessString += String(i)
                }
                
                incorrectGuessLabel.text = incorrectGuessString
            }
        }
    }
    
    func containsOnlyLetters(input: String) -> Bool {
        for chr in input.characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }

    
    
//    @IBAction func correctButtonPressed(sender: AnyObject) {
//        var currGuess = guessStatus.text
//        if (currGuess!.characters.last == " ") {
//            currGuess = String(currGuess!.characters.dropLast())
//            currGuess = String(currGuess!.characters.dropLast())
//        } else {
//            currGuess = String(currGuess!.characters.dropLast())
//        }
//        
//        inputTextField.text = ""
//        guessStatus.text = currGuess
//        
//    }
//    
//    @IBAction func incorrectButtonPressed(sender: AnyObject) {
//        var error = 0
//        if (inputTextField.text?.characters.count < 1) {
//            let alert = UIAlertView()
//            alert.title = "Error"
//            alert.message = "No inputted characters"
//            alert.addButtonWithTitle("OK")
//            alert.show()
//            
//            inputTextField.text = ""
//            error = 1
//        } else if (inputTextField.text?.characters.count > 1) {
//            let alert = UIAlertView()
//            alert.title = "Error"
//            alert.message = "Too many characters"
//            alert.addButtonWithTitle("OK")
//            alert.show()
//            
//            inputTextField.text = ""
//            error = 1
//        } else {
//            let isChar = containsOnlyLetters(inputTextField.text!)
//            if (!isChar) {
//                let alert = UIAlertView()
//                alert.title = "Error"
//                alert.message = "Guess must be an alphabetical character"
//                alert.addButtonWithTitle("OK")
//                inputTextField.text = ""
//                error = 1
//            }
//        }
//        if (error == 0) {
//            incorrectChars[0] = (inputTextField.text!)
//            inputTextField.text = ""
//        
//        
//            incorrectCount++
//            if (incorrectCount == 0) {
//                hangmanImage.image = UIImage(named: "hangman1.gif")
//            } else if (incorrectCount == 1) {
//                hangmanImage.image = UIImage(named: "hangman2.gif")
//            } else if (incorrectCount == 2) {
//                hangmanImage.image = UIImage(named: "hangman3.gif")
//            } else if (incorrectCount == 3) {
//                hangmanImage.image = UIImage(named: "hangman4.gif")
//            } else if (incorrectCount == 4) {
//                hangmanImage.image = UIImage(named: "hangman5.gif")
//            } else if (incorrectCount == 5) {
//                hangmanImage.image = UIImage(named: "hangman6.gif")
//            } else if (incorrectCount == 6) {
//                hangmanImage.image = UIImage(named: "hangman7.gif")
//            }
//
//        
//            for i in incorrectChars {
//                incorrectGuessString += String(i)
//            }
//        
//            incorrectGuessLabel.text = incorrectGuessString
//        }
//    }
//
    
    
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
