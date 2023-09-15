//
//  Card.swift
//  MySet
//
//  Created by Ivan Bezsonov on 07.09.2023.
//

import Foundation

struct Card: Equatable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return ((lhs.amount == rhs.amount) &&
                (lhs.color == rhs.color) &&
                (lhs.shading == rhs.shading) &&
                (lhs.form == rhs.form)
                )
    }
        
    var form: Property
    var color: Property
    var amount: Property
    var shading: Property
    
    enum Property: Int {
        
    case one = 1
    case two
    case three
    static var all : [Property] {return [.one, .two, .three]}

    }

    
}
