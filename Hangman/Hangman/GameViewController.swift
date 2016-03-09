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
    
    @IBOutlet weak var guessButton: UIButton!
    
    var phraseGuess:String = ""
    
    var correctChars:[Character] = []
    
    var incorrectChars:[Character] = []
    
    var incorrectGuessString:String = ""
    
    var incorrectCount = 0
    
    var keyPhrase:[Character] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
    
        keyPhrase = Array(phrase.characters)
        
        hangmanImage.image = UIImage(named: "hangman1.gif")
        
        correctChars.removeAll()
        incorrectChars.removeAll()
        incorrectGuessString = "Incorrect Guesses: "
        incorrectGuessLabel.text = incorrectGuessString
        incorrectCount = 0
        inputTextField.hidden = false;
        guessButton.hidden = false;
        
        phraseGuess = ""
        
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
        } else if (inputTextField.text?.characters.count == 1){
            let upperInput = inputTextField.text?.uppercaseString
            let guessChar = Array(upperInput!.characters)[0]
            
            let isChar = containsOnlyLetters(inputTextField.text!)
            if (!isChar || guessChar == " ") {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "Guess must be an alphabetical character"
                alert.addButtonWithTitle("OK")
                inputTextField.text = ""
                error = true
            }
            
            if (correctChars.contains(guessChar) || incorrectChars.contains(guessChar)) {
                let alert = UIAlertView()
                alert.title = "Error"
                alert.message = "Already guessed"
                alert.addButtonWithTitle("OK")
                alert.show()
                
                inputTextField.text = ""
                error = true
            }

        }
        
        if (error == false) {
            var contains = false
            
            let upperInput = inputTextField.text?.uppercaseString
            
            let guessChar = Array(upperInput!.characters)[0]
            
            contains = keyPhrase.contains(guessChar)
            
            //correct
            if (contains == true) {
                var finished = true
                
                correctChars.append(guessChar)
                phraseGuess = ""
                for var i = 0; i < keyPhrase.count; i++ {
                    if (keyPhrase[i] == " ") {
                        phraseGuess += " "
                    } else {
                        if (correctChars.contains(keyPhrase[i])) {
                            phraseGuess += String(keyPhrase[i]).uppercaseString
                        } else {
                            phraseGuess += "_"
                            finished = false
                        }
                    }
                }
                guessStatus.text = phraseGuess
                inputTextField.text = ""
                
                if (finished == true) {
                    let alert = UIAlertView()
                    alert.title = "GAME OVER"
                    alert.message = "You win! :)"
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                    inputTextField.text = ""
                    inputTextField.hidden = true;
                    guessButton.hidden = true;
                }
            } else {
                //incorrect
                incorrectChars.append(guessChar)
                
                //incorrectChars[incorrectCount] = inputTextField.text!.characters.first!
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
                    let alert = UIAlertView()
                    alert.title = "GAME OVER"
                    alert.message = "You lose :("
                    alert.addButtonWithTitle("OK")
                    alert.show()
                    
                    
                    inputTextField.text = ""
                    inputTextField.hidden = true;
                    guessButton.hidden = true;
                }
                incorrectGuessString += String(incorrectChars[incorrectChars.count-1])
                
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

    @IBAction func newGameButtonPressed(sender: AnyObject) {
        viewDidLoad()
    }
    
    @IBAction func startOverButtonPressed(sender: AnyObject) {
        
        hangmanImage.image = UIImage(named: "hangman1.gif")
        
        correctChars.removeAll()
        incorrectChars.removeAll()
        incorrectGuessString = "Incorrect Guesses: "
        incorrectGuessLabel.text = incorrectGuessString
        incorrectCount = 0
        
        phraseGuess = ""
        
        for var i = 0; i < keyPhrase.count; i++ {
            if (keyPhrase[i] == " ") {
                phraseGuess += " "
            } else {
                phraseGuess += "_"
            }
        }
        
        guessStatus.text = phraseGuess
        
        inputTextField.hidden = false;
        guessButton.hidden = false;
    }
    
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
