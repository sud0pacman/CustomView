//
//  ContentView.swift
//  CustomView
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI

struct ContentView: View {
    @Environment(Game.self) var game
    
    private let threeColumnGrid = [
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
        GridItem(.flexible(minimum: 40)),
    ]
    
    var body: some View {
        
        VStack {
            LazyVGrid(columns: threeColumnGrid, alignment: .center) {
                ForEach(game.directions.indices, id: \.self) { index in
                    let imageName = game.directions[index]
                    Rectangle()
                        .foregroundColor(.red)
                        .aspectRatio(1, contentMode: .fit)
                        .overlay {
                            Image(systemName: imageName.image)
                        }
                }
            }
            
            Text("\(game.directions.count)")
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .environment(Game())
}
