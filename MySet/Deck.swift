//
//  Deck.swift
//  MySet
//
//  Created by Ivan Bezsonov on 07.09.2023.
//

import Foundation

struct Deck {
    
    var cards = [Card]()
    
    init() {
        for color in Card.Property.all {
            for form in Card.Property.all {
                for amount in Card.Property.all {
                    for shading in Card.Property.all {
                        cards.append(Card(form: form, color: color, amount: amount, shading: shading))
                        cards.shuffle()
                    }
                }
            }
        }
    }
    
    mutating func draw() -> Card? {
        if cards.count > 0 {
            return cards.remove(at: cards.count.arc4random)
        } else {
            return nil
        }
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
