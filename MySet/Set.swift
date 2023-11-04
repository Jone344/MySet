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
                if selectedCards.count < 3 {
                    if let indexTouchedRepeat = selectedCards.firstIndex(of: cardsOnTable[index]) {
                        selectedCards.remove(at: indexTouchedRepeat)
                    }
                }
            }
        }
    }
    
    func cleaningSelectedCardsArrayWhenCountEquelThree() -> Bool {
        if toTryMatchCards() {
            for index in cardsOnTable.indices {
                let card = cardsOnTable[index]
                for indexSelect in selectedCards.indices {
                    let matchedCard = selectedCards[indexSelect]
                    if matchedCard == card {
                        if deck.cards.count > 0 {
                            if selectedCards.count != 0 {
                                alreadyMatched.append(matchedCard)
                                cardsOnTable.replace([card], with: [deck.cards.remove(at:deck.cards.count.arc4random)])
                            }
                        }
                    }
                }
            }
        }
        if selectedCards.count == 4 {
            var lastElement: [Card] = [selectedCards.removeLast()]
          //  tryMatchCards = selectedCards
            selectedCards = []
            selectedCards.append(lastElement[0])
            lastElement = []
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
    
    func addThreeCardsOnTable() {
        if deck.cards.count != 0 {
            for _ in 0...2 {
                cardsOnTable.append(deck.cards.removeFirst())
            }
        }
    }
    
    func toTryMatchCards() -> Bool {
//        var count = 0
//        if selectedCards.count == 3 {
//            if selectedCards[0].amount == selectedCards[1].amount && selectedCards[1].amount == selectedCards[2].amount || selectedCards[0].amount != selectedCards[1].amount && selectedCards[1].amount != selectedCards[2].amount && selectedCards[0].amount != selectedCards[2].amount {
//                count += 1
//            }
//            if selectedCards[0].color == selectedCards[1].color && selectedCards[1].color == selectedCards[2].color || selectedCards[0].color != selectedCards[1].color && selectedCards[1].color != selectedCards[2].color && selectedCards[0].color != selectedCards[2].color {
//                count += 1
//            }
//            if selectedCards[0].form == selectedCards[1].form && selectedCards[1].form == selectedCards[2].form || selectedCards[0].form != selectedCards[1].form && selectedCards[1].form != selectedCards[2].form && selectedCards[0].form != selectedCards[2].form {
//                count += 1
//            }
//            if selectedCards[0].shading == selectedCards[1].shading && selectedCards[1].shading == selectedCards[2].shading || selectedCards[0].shading != selectedCards[1].shading && selectedCards[1].shading != selectedCards[2].shading && selectedCards[0].shading != selectedCards[2].shading {
//                count += 1
//            }
//            if count == 4 {
//                count = 0
//                return true
//            }
//        }
//        count = 0
//        return false
        return true
    }
}
