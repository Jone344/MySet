//
//  Set.swift
//  MySet
//
//  Created by Ivan Bezsonov on 07.09.2023.
//

import Foundation

class Set {
    
    var deck = Deck()
    var cardsOnTable = [Card]()
    
    
    func fillingCardsOnTable() {
        for _ in 0...24 {
            if deck.cards.count > 0 {
                if cardsOnTable.count < 25 {
                    cardsOnTable.append(deck.cards.removeFirst())                    
                }
            }
        }
    }
}

