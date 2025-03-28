//
//  SetModel.swift
//  Set
//
//  Created by aruhil on 2025-03-18.
//

import Foundation
import SwiftUI

struct CardGame {
    var cards: [CardFeatures] = []
    var selectedCards: [CardFeatures] = []
    var setCount = 0
    var createCards: (Int) -> CardFeatures
    
    init(numCards: Int, cardContent: @escaping (Int) -> CardFeatures) {
        for i in 0..<numCards {
            let card = cardContent(i)
            cards.append(card)
        }
        createCards = cardContent
        print(cards)
    }
    
    mutating func newGame() {
        let cardsOnDeck = cards.count
        cards = []
        for i in 0..<cardsOnDeck {
            let card = createCards(i)
            cards.append(card)
        }
        setCount = 0
    }
    
    mutating func choose(card: CardFeatures) {
        guard let index = cards.firstIndex(of: card) else {
            return
        }
        cards[index].isSelected.toggle()
        if cards[index].isSelected {
            selectedCards.append(cards[index])
        } else {
            if let selectedIndex = selectedCards.firstIndex(of: card) {
                selectedCards.remove(at: selectedIndex)
            }
        }
        
        handeSelectedCards()
    }
    
    mutating func handeSelectedCards() {
        if selectedCards.count == 3 {
            if checkSetLogic() {
                setCount += 1
            }
            discard()
            selectedCards = []
        }
    }
    
    mutating func discard() {
        for i in (0..<selectedCards.count) {
            guard let idx = cards.firstIndex(of: selectedCards[i]) else {
                return
            }
            cards[idx].isSelected = false
        }
    }
    
    func checkSetLogic() -> Bool {
        var numberCondition = false
        var colorCondition = false
        var shapeCondition = false
        var shadingCondition = false
        let card1 = selectedCards[0]
        let card2 = selectedCards[1]
        let card3 = selectedCards[2]
        
        let isSameNumber = (card1.numberOfShapes == card2.numberOfShapes) && (card2.numberOfShapes == card3.numberOfShapes)
        let isSameColor = (card1.color == card2.color) && (card2.color == card3.color)
        let isSameShape = (card1.shape == card2.shape) && (card2.shape == card3.shape)
        let isSameShading = (card1.shading == card2.shading) && (card2.shading == card3.shading)
        
        let isDiffNumber = (card1.numberOfShapes != card2.numberOfShapes) && (card2.numberOfShapes != card3.numberOfShapes) && (card1.numberOfShapes != card2.numberOfShapes)
        let isDiffColor = (card1.color != card2.color) && (card2.color != card3.color) && (card1.color != card2.color)
        let isDiffShape = (card1.shape != card2.shape) && (card2.shape != card3.shape) && (card1.shape != card2.shape)
        let isDiffShading = (card1.shading != card2.shading) && (card2.shading != card3.shading) && (card1.shading != card2.shading)
        
        numberCondition = isSameNumber || isDiffNumber
        colorCondition = isSameColor || isDiffColor
        shapeCondition = isSameShape || isDiffShape
        shadingCondition = isSameShading || isDiffShading
        
        return numberCondition && colorCondition && shapeCondition && shadingCondition
    }
}

struct CardFeatures: Identifiable, Equatable {
    let id = UUID()
    var numberOfShapes: Int = 1
    var color: CardColor = .green
    var shape: CardShape = .diamond
    var shading: CardShade = .opaque
    var isSelected: Bool = false
}

enum CardColor: CaseIterable {
    case red
    case green
    case purple
    
    func color() -> Color {
        switch self {
        case .red: return .red
        case .green: return .green
        case .purple: return .purple
        }
    }
}

enum CardShade: CGFloat, CaseIterable {
    case opaque = 1
    case translucent = 0.5
    case transparent = 0
}

enum CardShape: CaseIterable {
    case diamond
    case oval
    case squiggle
    
    func shape() -> AnyShape {
        switch self {
        case .diamond: return AnyShape(Diamond())
        case .oval: return AnyShape(Oval())
        case .squiggle: return AnyShape(Squiggle())
        }
    }
}


struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let top = CGPoint(x: rect.midX, y: rect.minY)
        let left = CGPoint(x: rect.minX, y: rect.midY)
        let bottom = CGPoint(x: rect.midX, y: rect.maxY)
        let right = CGPoint(x: rect.maxX, y: rect.midY)
        
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: bottom)
        path.addLine(to: right)
        path.addLine(to: top)
        
        return path
    }
}

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addEllipse(in: rect)
        return path
    }
}

struct Squiggle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start point (left center)
        let start = CGPoint(x: rect.minX, y: rect.maxY)
        
        // First curve (moves right)
        let control1 = CGPoint(x: rect.minX, y: rect.minY)
        let control2 = CGPoint(x: rect.midX, y: rect.maxY)
        let end = CGPoint(x: rect.maxX, y: rect.midY)
        
        // Second curve (moves back left to close the shape)
        let control3 = CGPoint(x: rect.maxX, y: rect.maxY)
        let control4 = CGPoint(x: rect.maxX, y: rect.maxY)
        
        path.move(to: start)
        path.addCurve(to: end, control1: control1, control2: control2)
        path.addCurve(to: start, control1: control3, control2: control4)
        return path
    }
}



/*

path.move(to: CGPoint(x: rect.minX, y: rect.midY))
path.addCurve(to: CGPoint(x: rect.maxX, y: rect.midY),
              control1: CGPoint(x: rect.midX - 20, y: rect.minY),
              control2: CGPoint(x: rect.midX + 20, y: rect.maxY))
*/
