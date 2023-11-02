//
//  ViewController.swift
//  MySet
//
//  Created by Ivan Bezsonov on 07.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var game = Set()
    
    let figures = ["▲","■","●"]
    let colors = [UIColor.purple, .green, .red]
    let shading: [CGFloat] = [1.0, 0.35]
    let strokeWidths = [4, -4]
    let sizeFigures: CGFloat = 20.0

    override func viewDidLoad() {
        super.viewDidLoad()
        game.fillingCardsOnTable()
        add3Cards.layer.cornerRadius = 8.0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < game.cardsOnTable.count { // < 12
            let card = game.cardsOnTable[index]
                button.layer.cornerRadius = 8.0
                button.backgroundColor = UIColor.white
                    
                button.setAttributedTitle(figuresGetFilling(for: card, and: button), for: UIControl.State.normal)
            } else {
                button.backgroundColor = UIColor.clear
            }
        }
    }
    
    func buttonsGetFigure(for card: Card, and button: UIButton) -> String {
        switch card.form {
            case .one:
              //  button.setTitle(figures[0], for: UIControl.State.normal)
                return figures[0]
            
            case .two:
               // button.setTitle(figures[1], for: UIControl.State.normal)
                return figures[1]

            case .three:
             //   button.setTitle(figures[2], for: UIControl.State.normal)
                return figures[2]
        }
    }
    
    func titleGetCount(for card: Card, and button: UIButton) -> String{

        switch card.amount {
            case .one:
                return "\(buttonsGetFigure(for: card, and: button))"
            
            case .two:
                return "\(buttonsGetFigure(for: card, and: button))\n\(buttonsGetFigure(for: card, and: button))"
            
            case .three:
                return "\(buttonsGetFigure(for: card, and: button))\n\(buttonsGetFigure(for: card, and: button))\n\(buttonsGetFigure(for: card, and: button))"
        }
    }
    
    func figuresGetColor(for card: Card, and button: UIButton) -> UIColor {
        switch card.color {
            case .one:
             //    button.setTitleColor(colors[0], for: UIControl.State.normal)
                return colors[0]
            case .two:
             //    button.setTitleColor(colors[1], for: UIControl.State.normal)
                return colors[1]
            case .three:
            //    button.setTitleColor(colors[2], for: UIControl.State.normal)
                return colors[2]
        }
    }
    
    func figuresGetFilling(for card: Card, and button: UIButton) -> NSAttributedString {

        switch card.shading {
        case .one:
            let firstAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: sizeFigures),
                .strokeWidth: strokeWidths[0],
                .strokeColor: figuresGetColor(for: card, and: button).withAlphaComponent(shading[0]),
            ]
            return NSAttributedString(string: titleGetCount(for: card, and: button), attributes: firstAttributes)
            
        case .two:
            let secondAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor:  figuresGetColor(for: card, and: button).withAlphaComponent(shading[1]),
                .font: UIFont.systemFont(ofSize: sizeFigures),
                .strokeColor: figuresGetColor(for: card, and: button).withAlphaComponent(shading[0]),
                .strokeWidth: strokeWidths[1],
            ]
            return NSAttributedString(string: titleGetCount(for: card, and: button), attributes: secondAttributes)
            
        case .three:
            let treyAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor:  figuresGetColor(for: card, and: button).withAlphaComponent(shading[0]),
                .font: UIFont.systemFont(ofSize: sizeFigures),
                .strokeWidth: strokeWidths[1],
                .strokeColor: figuresGetColor(for: card, and: button).withAlphaComponent(shading[0]),
            ]
            return NSAttributedString(string: titleGetCount(for: card, and: button), attributes: treyAttributes)
        }
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.lastIndex(of: sender) {
            if sender.layer.backgroundColor == UIColor.white.cgColor { // choose onle if card can see
                if sender.layer.borderColor != UIColor.green.cgColor {
                    game.getSelectedCards(index: cardNumber)
                    updateViewFromModelCheckAndPaintOverSelectedCards(sender)
                    afterThreeCardsChoosed(sender: sender)
                    makeGreenBorder(sender: sender)
                    toReplaceCards()
                }
            }
        }
    }
      
    var greenColorBorder = [UIButton]()
    var blueColorBorder = [UIButton]()
    
    func updateViewFromModelCheckAndPaintOverSelectedCards(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender){
            if sender.layer.borderColor != UIColor.blue.cgColor {
                sender.layer.borderWidth = 3.0
                sender.layer.borderColor = UIColor.blue.cgColor
                blueColorBorder.append(sender)
            } else {
                    for index in blueColorBorder.indices {
                        let blueBorder = blueColorBorder[index]
                        if blueColorBorder.count < 3 {
                        sender.layer.borderWidth = 0.0
                        sender.layer.borderColor = UIColor.clear.cgColor
                            if blueBorder == sender {
                                blueColorBorder.remove(at: index)
                                break
                            }
                        }
                    }
                }
            }
    }
    
    var countColorsBorder = 0
    func afterThreeCardsChoosed(sender: UIButton) {
        for button in cardButtons {
            if button.layer.borderWidth == 3.0 {
                countColorsBorder += 1
            }
            if countColorsBorder == 4 {
                for button in cardButtons {
                    button.layer.borderWidth = 0.0
                    button.layer.borderColor = UIColor.clear.cgColor
                }
                sender.layer.borderWidth = 3.0
                sender.layer.borderColor = UIColor.blue.cgColor
                let lastElement = blueColorBorder.removeLast()
                blueColorBorder = []
                blueColorBorder.append(lastElement)
            }
        }
        countColorsBorder = 0
    }
    
    func makeGreenBorder(sender: UIButton) {
        if game.toTryMatchCards() {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                for greenBorder in blueColorBorder {
                    if button == greenBorder {
                        if blueColorBorder.count == 3 {
                            button.layer.borderWidth = 3.0
                            button.layer.borderColor = UIColor.green.cgColor
                        }
                    }
                }
            }
        }
        if blueColorBorder.count == 3 {
            blueColorBorder = []
        }
    }
    
    func toReplaceCards() {
        if game.cleaningSelectedCardsArrayWhenCountEquelThree() {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                if index < game.cardsOnTable.count { // that no will see cards still out game. Instead < 12.
                    let card = game.cardsOnTable[index]
                    button.setAttributedTitle(figuresGetFilling(for: card, and: button), for: UIControl.State.normal)
                }
            }
        }
    }
    
    @IBAction func addThreeCards(_ sender: UIButton) {
        game.addThreeCardsOnTable()
        for index in cardButtons.indices {
            let button = cardButtons[index]
            if index < game.cardsOnTable.count { // < 12
                let card = game.cardsOnTable[index]
                button.layer.cornerRadius = 8.0
                button.backgroundColor = UIColor.white
                    
                button.setAttributedTitle(figuresGetFilling(for: card, and: button), for: UIControl.State.normal)
            } else {
                button.backgroundColor = UIColor.clear
            }
        }
    }
    
    @IBOutlet weak var add3Cards: UIButton!
    
    @IBOutlet var cardButtons: [UIButton]!
}

