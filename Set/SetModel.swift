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
    
    init(numCards: Int, cardContent: (Int) -> CardFeatures) {
        for i in 0..<numCards {
            let card = cardContent(i)
            cards.append(card)
        }
        print(cards)
    }
}

struct CardFeatures: Identifiable {
    let id = UUID()
    var numberOfShapes: Int
    var color: Color
    var shape: CardShape
    var shading: CardShade
}

enum CardShade: CGFloat {
    case opaque = 1
    case translucent = 0.5
    case transparent = 0
}

enum CardShape {
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
