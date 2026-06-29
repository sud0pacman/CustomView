//
//  GridView.swift
//  CustomView
//
//  Created by G'aniyev Muhammad on 29/06/26.
//

import SwiftUI

struct GridView: View {
    @Environment(Game.self) private var game

    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: game.size)
        
        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(game.grid.indices, id: \.self) { index in
                ArrowTileView(index: index)
            }
        }
        .id(game.size)
    }
}
