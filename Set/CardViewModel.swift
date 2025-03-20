//
//  CardViewModel.swift
//  Set
//
//  Created by Anshul Ruhil on 2025-03-19.
//

import Foundation

func createCardFeatures (index: Int) -> CardFeatures {
    return CardFeatures(
        numberOfShapes: 3,
        color: .blue,
        shape: CardShape.diamond,
        shading: CardShade.opaque)
}

class CardViewModel: ObservableObject {
    @Published var model = CardGame(numCards: 15, cardContent: createCardFeatures)
    var cards: [CardFeatures] {
        model.cards
    }
}
