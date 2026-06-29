//
//  HeaderView.swift
//  CustomView
//
//  Created by G'aniyev Muhammad on 29/06/26.
//

import SwiftUI

struct HeaderView: View {
    @Environment(Game.self) private var game

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Arrow")
                Text("escape")
            }
            .font(.system(size: 28, weight: .bold, design: .default))
            .foregroundStyle(.primary)

            Spacer()
            
            StatPill(value: game.remaining, label: "left")
        }
    }
}
