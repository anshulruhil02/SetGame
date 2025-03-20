//
//  ContentView.swift
//  Set
//
//  Created by aruhil on 2025-03-18.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: CardViewModel
    var body: some View {
        VStack {
            Text("Set")
                .font(.title)
                
            GeometryReader {  geometry in
                let cardSize = maxCardWidth(
                    count: viewModel.cards.count,
                    size: geometry.size,
                    aspectRatio: 1/3
                )
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: cardSize))]) {
                        ForEach(viewModel.cards) { card in
                            CardView(card: card, size: cardSize)
                                .aspectRatio( 1/3, contentMode: .fit)
                        }
                    }
                }
            }
            
        }
    }
}

func maxCardWidth(
    count: Int,
    size: CGSize,
    aspectRatio: CGFloat
) -> CGFloat {
    var columnCount = 1.0
    let count = CGFloat(count)
    repeat {
        let width = size.width / CGFloat(columnCount)
        let height = width / aspectRatio
        let rowCount = (count / columnCount).rounded(.up)
        
        if rowCount * height < size.height {
            print("Here")
            return width.rounded(.down)
        }
        
        columnCount += 1
    } while columnCount < count
    
    return min(size.width / count, (aspectRatio * size.height).rounded(.down))
}

struct CardView: View { 
    let card: CardFeatures
    let base = Rectangle()
    var size: CGFloat
    var body: some View {
        ZStack {
            base
                .fill(.yellow)
                .strokeBorder(.black)
            GeometryReader { geometry in
                VStack{
                    ForEach(0..<card.numberOfShapes) { _ in
                        Spacer()
                        card.shape.shape()
                            .fill(card.color)
                        Spacer()
                    }
                }
                
            }
        }
    }
}
