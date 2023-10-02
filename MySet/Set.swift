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
        if selectedCards.count == 3 {
            tryMatchCards = selectedCards
            //let savedLastCard = tryMatchCards.removeLast()
            tryMatchCards.removeAll()
            selectedCards = []
            //selectedCards.append(savedLastCard)
            
            return true
           // selectedCards.append(cardsOnTable[index])
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
    
//    func checkCardsOnMatching() {
//        switch
//    }
}

