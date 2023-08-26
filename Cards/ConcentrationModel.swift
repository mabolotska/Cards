//
//  ConcentrationModel.swift
//  Cards
//
//  Created by Maryna Bolotska on 24/08/23.
//

import Foundation




class ConcentrationModel {
    var cards = [Card]()
    
    private(set) var score = 0
    private var seenCards: Set<Int> = []
    var flipCount = 0 
  
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            //we use filter
            //           let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            
            // we use oneAndOnly extension
        //    return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            
            
            //       return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp  {
                    guard foundIndex == nil else { return nil }
                    foundIndex = index
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
        
    }
    
    
    
   
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)) : Choosen index out of range")
        
        if !cards[index].isMatched {
           // flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {

                if cards[matchIndex].identifier == cards[index].identifier {
    //cards match
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    
                    // Increase the score
                    score += 2
                } else {
    //cards didn't match - Penalize
                    if seenCards.contains(index) {
                        score -= 1
                    }
                    if seenCards.contains(matchIndex) {
                        score -= 1
                    }
                    seenCards.insert(index)
                    seenCards.insert(matchIndex)
                }
                cards[index].isFaceUp = true
                
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
        init(numberOfPairsOfCards: Int) {
            assert(numberOfPairsOfCards > 0,
                   "Concentration.init(\(numberOfPairsOfCards)) : You must have at least one pair of cards")
            for _ in 1...numberOfPairsOfCards {
                let card = Card()
                
           //     let matchingCard = card
                cards += [card, card]
    //            cards.append(card)
    //            cards.append(card)
                cards.shuffle()
            }
        }
    
   
    
}


extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
