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
    var selectedCards = [Card]()
    var tryMatchCards = [Card]()
    var alreadyMatched = [Card]()
    
    func getSelectedCards(index: Int) {
        if selectedCards.count < 3 {
            if !selectedCards.contains(cardsOnTable[index]) {
                selectedCards.append(cardsOnTable[index])
            } else {
                if let indexTouchedRepeat = selectedCards.firstIndex(of: cardsOnTable[index]) {
                    selectedCards.remove(at: indexTouchedRepeat)
                }
            }
        }
    }
    
    func cleaningSelectedCardsArrayWhenCountEquelThree() -> Bool {
        for index in cardsOnTable.indices {
            let card = cardsOnTable[index]
            for index in selectedCards.indices {
                let matchedCard = selectedCards[index]
                if matchedCard == card {
                    if selectedCards.count == 3 {
                        if deck.cards.count > 0 {
                            cardsOnTable.replace([card], with: [deck.cards.remove(at:deck.cards.count.arc4random)])
                        }
                    }
                }
            }
        }
        if selectedCards.count == 3 {
            selectedCards = []
            return true
        }
        return false
    }
      
    func fillingCardsOnTable() {
        for _ in 0...23 {
            if deck.cards.count > 0 {
                if cardsOnTable.count < 25 {
                    cardsOnTable.append(deck.cards.removeFirst())
                }
            }
        }
    }
}
