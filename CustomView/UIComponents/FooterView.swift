//
//  FooterView.swift
//  CustomView
//
//  Created by G'aniyev Muhammad on 29/06/26.
//

import SwiftUI

struct FooterView: View {
    @Environment(Game.self) private var game

    var body: some View {
        HStack(spacing: 8) {
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
//                    game.undo()
                }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .medium))
                    Text("Undo")
                        .font(.system(size: 15, weight: .medium))
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(.background, in: RoundedRectangle(cornerRadius: 14))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .strokeBorder(Color.primary.opacity(0.12), lineWidth: 0.5)
                )
            }
            .foregroundStyle(.primary)
            .disabled(false)

            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    game.newGame()
                }
            } label: {
                Text("New game")
                    .font(.system(size: 15, weight: .medium))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.primary, in: RoundedRectangle(cornerRadius: 14))
                    .foregroundStyle(Color(UIColor.systemBackground))
            }
        }
    }
}
