//
//  ConcentrationModel.swift
//  Cards
//
//  Created by Maryna Bolotska on 24/08/23.
//

import Foundation


class ConcentrationModel {
    var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            //we use filter
 //           let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }
            
            // we use oneAndOnly extension
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            
            
     //       return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp  {
//                    guard foundIndex == nil else { return nil }
//                    foundIndex = index
//                }
//            }
//            return foundIndex
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
        if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
            //we can delete identifier because we use hashable rhs == lhs
            if cards[matchIndex] == cards[index] {
                //cards match
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
           
                // Increase the score
                //      score += Points.matchBonus
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
