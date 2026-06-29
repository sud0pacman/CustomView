//
//  HintBarView.swift
//  CustomView
//
//  Created by G'aniyev Muhammad on 29/06/26.
//

import SwiftUI

struct HintBarView: View {
    @Environment(Game.self) private var game

    private var hintText: String {
        if game.isCleared { return "All arrows escaped!" }
        let canCount = game.grid.indices.filter {
            game.grid[$0].isOnBoard && game.canEscape(at: $0)
        }.count
        return canCount > 0
            ? "Tap a green-dotted arrow — its path is clear."
            : "No arrow can escape yet — think ahead."
    }

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(game.isCleared ? Color.green : Color.green.opacity(0.8))
                .frame(width: 8, height: 8)
            Text(hintText)
                .font(.system(size: 12))
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(.background, in: RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.primary.opacity(0.06), lineWidth: 0.5)
        )
    }
}

