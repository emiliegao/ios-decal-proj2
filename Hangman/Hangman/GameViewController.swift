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
    
    var incorrectChars:[Character] = []
    
    var incorrectGuessString:String = "Incorrect Guesses: "
    
    var incorrectCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        let phrase = hangmanPhrases.getRandomPhrase()
        
        incorrectCount = incorrectChars.count
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
        }

        
        for i in phrase.characters.indices {
            if (phrase[i] == " ") {
                phraseGuess += " "
            } else {
                phraseGuess += "_"
            }
        }
        
        guessStatus.text = phraseGuess

        for i in incorrectChars {
            incorrectGuessString += String(i)
        }
        
        incorrectGuessLabel.text = incorrectGuessString
        
        print(phrase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func correctButtonPressed(sender: AnyObject) {
        var currGuess = guessStatus.text
        if (currGuess!.characters.last == " ") {
            currGuess =
                String(currGuess!.characters.dropLast())
        } else {
            currGuess = String(currGuess!.characters.dropLast())
        }
        
        guessStatus.text = currGuess
        
    }
    
    @IBAction func incorrectButtonPressed(sender: AnyObject) {
        
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
