//
//  ArrowTileView.swift
//  CustomView
//
//  Created by G'aniyev Muhammad on 29/06/26.
//

import SwiftUI

struct ArrowTileView: View {
    let index: Int
    @Environment(Game.self) private var game

    @State private var flyOffset: CGSize = .zero
    @State private var opacity: Double = 1
    @State private var shaking = false
    @State private var scale: CGFloat = 1

    private var arrow: Arrow { game.grid[index] }
    private var canEscape: Bool { game.canEscape(at: index) }

    var body: some View {
        Group {
            if arrow.isOnBoard {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.red)
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .strokeBorder(Color.primary.opacity(0.08), lineWidth: 0.5)
                        )

                    Text(arrow.direction.glyph)
                        .font(.system(size: 26, weight: .regular))
                        .foregroundStyle(.primary)

                    if canEscape {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 7, height: 7)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                            .padding(8)
                    }
                }
                .aspectRatio(1, contentMode: .fit)
                .scaleEffect(scale)
                .offset(flyOffset)
                .opacity(opacity)
                .offset(x: shaking ? -4 : 0)
                .onTapGesture { handleTap() }
            } else {
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(Color.primary.opacity(0.08), style: StrokeStyle(lineWidth: 0.5, dash: [4]))
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }

    private func handleTap() {
        guard arrow.isOnBoard else { return }

        if canEscape {
            let (dx, dy) = flyVector()
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                scale = 0.85
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation(.easeIn(duration: 0.28)) {
                    flyOffset = CGSize(width: dx, height: dy)
                    opacity = 0
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    game.tap(at: index)
                    flyOffset = .zero
                    opacity = 1
                    scale = 1
                }
            }
        } else {
            withAnimation(.default) { shaking = true }
            withAnimation(.default.delay(0.15)) { shaking = false }
        }
    }

    private func flyVector() -> (CGFloat, CGFloat) {
        let dist: CGFloat = 400
        switch arrow.direction {
        case .up:    return (0, -dist)
        case .down:  return (0,  dist)
        case .left:  return (-dist, 0)
        case .right: return ( dist, 0)
        }
    }
}
