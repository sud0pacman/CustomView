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
