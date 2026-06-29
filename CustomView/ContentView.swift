//
//  ContentView.swift
//  CustomView
//
//  Created by Muhammad on 04/06/26.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @Environment(Game.self) private var game

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground).ignoresSafeArea()

            VStack(spacing: 0) {
                HeaderView()
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 20)

                SizeSelectorView()
                    .padding(.horizontal, 20)
                    .padding(.bottom, 14)

                HintBarView()
                    .padding(.horizontal, 20)
                    .padding(.bottom, 14)

                GridView()
                    .padding(.horizontal, 20)

                Spacer(minLength: 0)

                FooterView()
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
            }
        }
    }
}

// MARK: - Size Selector
private struct SizeSelectorView: View {
    @Environment(Game.self) private var game
    private let sizes = [3, 4, 5, 6]

    var body: some View {
        HStack(spacing: 2) {
            ForEach(sizes, id: \.self) { n in
                Button("\(n)×\(n)") {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        game.newGame(size: n)
                    }
                }
                .font(.system(size: 13, weight: .medium))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 6)
                .background(
                    game.size == n
                        ? AnyShapeStyle(.background)
                        : AnyShapeStyle(.clear)
                )
                .foregroundStyle(game.size == n ? .primary : .secondary)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(2)
        .background(Color(.systemFill), in: RoundedRectangle(cornerRadius: 10))
    }
}
