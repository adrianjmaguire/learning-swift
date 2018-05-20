//
//  ViewController.swift
//  Concentration
//
//  Created by AdrianM on 16/05/2018.
//  Copyright © 2018 AdrianM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!

    @IBOutlet weak var thumbsUp: UILabel!
    
    @IBAction func buttonTouched(_ sender: UIButton, forEvent event: UIEvent) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in card buttons")
        }
    }
    
    func updateViewFromModel()
    {
        var allMatched = true
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            flipCount = game.flipCount
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.6910327673, green: 0.6910327673, blue: 0.6910327673, alpha: 0) : #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
                button.setTitle(card.isMatched ? "👍" : "🔮", for: UIControlState.normal)
            }
            if !card.isMatched {
                allMatched = false
            }
        }
        
        if allMatched {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                button.isHidden = true
            }
            thumbsUp.isHidden = false
            flipCountLabel.text = "Final score: \(flipCount)"
        }
        
    }
    var emojiCoices = ["🎃", "👻", "😸", "👽", "🐙", "🍁", "🐳", "🐨", "🙈", "🐝","💩","💰"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiCoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiCoices.count)))
            emoji[card.identifier] = emojiCoices.remove(at: randomIndex)
            
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
    
}

