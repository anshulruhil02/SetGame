//
//  CardViewModel.swift
//  Set
//
//  Created by Anshul Ruhil on 2025-03-19.
//

import Foundation

func createCardFeatures (index: Int) -> CardFeatures {
    guard let shapeCount = [1,2,3].randomElement() else {
        print("unexpected error: wrong count")
        return CardFeatures()
    }
    
    guard let color = CardColor.allCases.randomElement() else {
        print("unexpected error: wrong color")
        return CardFeatures()
    }
    
    guard let shape = CardShape.allCases.randomElement() else {
        print("unexpected error: wrong shape")
        return CardFeatures()
    }
    
    guard let shading = CardShade.allCases.randomElement()  else{
        print("unexpected error: wrong shading")
        return CardFeatures()
    }
    
    return CardFeatures(
        numberOfShapes: shapeCount,
        color: color,
        shape: shape,
        shading: shading,
        isSelected: false
    )
}

class CardViewModel: ObservableObject {
    @Published var model = CardGame(numCards: 12, cardContent: createCardFeatures)
    var cards: [CardFeatures] {
        model.cards
    }
    
    func choose(card: CardFeatures) {
        model.choose(card: card)
    }
    
    var setsFound: Int {
        model.setCount
    }
    
    func newGame() {
        model.newGame()
    }
}
