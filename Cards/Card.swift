//
//  Card.swift
//  Cards
//
//  Created by Maryna Bolotska on 24/08/23.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int {return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var cards: [Card] = []
    
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
 
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
