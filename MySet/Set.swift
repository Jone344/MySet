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
        if selectedCards.count < 4 {
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
        if selectedCards.count == 4 {
            var lastElement: [Card] = [selectedCards.removeLast()]
            tryMatchCards = selectedCards
            selectedCards = []
            selectedCards.append(lastElement[0])
            lastElement = []
        }
        for index in cardsOnTable.indices {
            let card = cardsOnTable[index]
            for indexSelect in tryMatchCards.indices {
                let matchedCard = tryMatchCards[indexSelect]
                if matchedCard == card {
                    if deck.cards.count > 0 {
                        if tryMatchCards.count != 0 {
                            cardsOnTable.replace([card], with: [deck.cards.remove(at:deck.cards.count.arc4random)])
                        }
                    }
                }
            }
        }
        tryMatchCards = []
        if selectedCards.count == 3 {
            return true
        }
        return false
    }
      
    func fillingCardsOnTable() {
        for _ in 0...11 {
            if deck.cards.count > 0 {
                cardsOnTable.append(deck.cards.removeFirst())
            }
        }
    }
    
    func addThreeCardsOnTable(at index: Int) {
        if deck.cards.count != 0 {
            for _ in 0...2 {
                if let indexAddedCard = selectedCards.firstIndex(of: cardsOnTable[index]) {
                    cardsOnTable.append(deck.cards.remove(at: indexAddedCard))
                }
            }
        }
    }
}
