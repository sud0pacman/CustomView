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
        let size = game.size
        let columns = Array(repeating: GridItem(.flexible(), spacing: 8), count: size)
        let tiles: [(index: Int, arrow: Arrow)] = game.grid.indices.map { i in
            (index: i, arrow: game.grid[i])
        }

        LazyVGrid(columns: columns, spacing: 8) {
            ForEach(tiles, id: \.index) { tile in
                let canEscape = game.canEscape(at: tile.index)
                ArrowTileView(index: tile.index, arrow: tile.arrow, canEscape: canEscape)
            }
        }
        .id(size)
    }
}
