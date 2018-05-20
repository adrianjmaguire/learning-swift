//
//  Concentration.swift
//  Concentration
//
//  Created by AdrianM on 17/05/2018.
//  Copyright © 2018 AdrianM. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var flipCount = 0
    
    func chooseCard(at index: Int) {
        print("indexOfOneAndOnlyFaceUpCard: \(String(describing: indexOfOneAndOnlyFaceUpCard ?? nil))")
        if !cards[index].isMatched {
            if !cards[index].isFaceUp {
                flipCount += 1
            }
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
            
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                print("index \(index)")
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
            
    }
    
    init(numberOfPairsOfCards: Int)
    {
        var cardsToShuffle = [Card]()
        let numberOfCardsInPlay = numberOfPairsOfCards * 2
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cardsToShuffle += [card, card]
        }
        
        for _ in 1...numberOfCardsInPlay {
            let randomIndex = Int(arc4random_uniform(UInt32(cardsToShuffle.count)))
            cards += [cardsToShuffle[randomIndex]]
            cardsToShuffle.remove(at: randomIndex)
        }
    }
}
