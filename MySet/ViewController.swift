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
    let sizeFigures: CGFloat = 24.0

    override func viewDidLoad() {
        super.viewDidLoad()
        game.fillingCardsOnTable()
        
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cardsOnTable[index]
            if index >= 12 {
                button.backgroundColor = UIColor.black
            } else {
                button.layer.cornerRadius = 8.0
                button.backgroundColor = UIColor.white

             //   button.layer.borderWidth = 3.0
              //  button.layer.borderColor = UIColor.blue.cgColor
                
                button.setAttributedTitle(figuresGetFilling(for: card, and: button), for: UIControl.State.normal)                
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
                game.getSelectedCards(index: cardNumber)
                updateViewFromModelCheckAndPaintOverSelectedCards(sender)
                makeGreenBorder(sender: sender)
                afterThreeCardsChoosed(sender: sender)
            }
        }
    }
      
    var greenColorBorder = [UIButton]()
    var blueColorBorder = [UIButton()]
    
    func updateViewFromModelCheckAndPaintOverSelectedCards(_ sender: UIButton) {
        if let cardNumber = cardButtons.lastIndex(of: sender) {
            if game.selectedCards.contains(game.cardsOnTable[cardNumber]) {
                sender.layer.borderWidth = 3.0
                sender.layer.borderColor = UIColor.blue.cgColor
                greenColorBorder.append(sender)
                blueColorBorder.append(sender)
            } else {
                sender.layer.borderWidth = 0.0
                sender.layer.borderColor = UIColor.clear.cgColor
            }
            
        }
    }
    
    func makeGreenBorder(sender: UIButton) {
        if game.cleaningSelectedCardsArrayWhenCountEquelThree() {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cardsOnTable[index]
                if index < 12 { // that no will see cards still out game
                    button.setAttributedTitle(figuresGetFilling(for: card, and: button), for: UIControl.State.normal)
                }
                for greenBorder in greenColorBorder {
                    if button == greenBorder {
                        button.layer.borderWidth = 3.0
                        button.layer.borderColor = UIColor.green.cgColor
                    }
                }
            }
        }
    }
    
    
    func afterThreeCardsChoosed(sender: UIButton) {
        var countColorsBorder = 0
        for button in cardButtons {
            if button.layer.borderWidth == 3.0 {
                countColorsBorder += 1
            }
        }
        if countColorsBorder == 4 {
            for index in cardButtons.indices {
                let button = cardButtons[index]
               // let card = game.cardsOnTable[index]
                button.layer.borderWidth = 0.0
                button.layer.borderColor = UIColor.clear.cgColor
            }
            greenColorBorder = []
            blueColorBorder = []
            sender.layer.borderWidth = 3.0
            sender.layer.borderColor = UIColor.blue.cgColor
            greenColorBorder.append(sender)
            blueColorBorder.append(sender)
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
}

