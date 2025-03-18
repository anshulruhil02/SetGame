//
//  ContentView.swift
//  Set
//
//  Created by aruhil on 2025-03-18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack {
//            Text("Set")
//            Spacer()
//                .font(.title)
        GeometryReader { geometry in
            let cardSize = maxCardWidth(
                count: 5,
                size: geometry.size,
                aspectRatio: 1/3
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: cardSize))]) {
                ForEach(0..<5) {_ in
                    CardView()
                        .aspectRatio( 1/3, contentMode: .fit)
                }
            }
        }
            
//            Spacer()
//        }
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
                return (size.width/columnCount).rounded(.down)
            }
            
            columnCount += 1
        } while columnCount < count
        
        return min(size.width / count, (aspectRatio * size.height).rounded(.down))
    }
}

struct CardView: View {
    let base = Rectangle()
    var body: some View {
//        ZStack {
            base
                .fill(.yellow)
                
//            VStack {
//                Diamond()
//                    .stroke(Color.red)
//                Diamond()
//                    .stroke(Color.red)
//            }

//        }
        
    }
}

#Preview {
    ContentView()
}
