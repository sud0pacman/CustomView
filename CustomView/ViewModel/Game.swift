//
//  Game.swift
//  CustomView
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI

@Observable
class Game {
    var directions: [Arrow] = []

    init() {
        collectRandomArrow(for: 3)
        print("Generated grid with \(directions.count) arrows.")
    }

    func collectRandomArrow(for size: Int) {
        directions.removeAll()
        
        for i in 0..<(size * size) {
            let row = i / size
            let col = i % size
            
            // Start with all possible choices
            var validChoices = ArrowDirection.allCases
            
            // 1. Check Left Neighbor (if we aren't in the first column)
            if col > 0 {
                let leftArrow = directions[i - 1].direction
                // Example Rule: Prevent arrows from pointing directly at each other (-> <-)
                if leftArrow == .right {
                    validChoices.removeAll { $0 == .left }
                }
            }
            
            // 2. Check Top Neighbor (if we aren't in the first row)
            if row > 0 {
                let topArrow = directions[i - size].direction
                // Example Rule: Prevent arrows from pointing directly at each other
                if topArrow == .down {
                    validChoices.removeAll { $0 == .up }
                }
            }
            
            // 3. Assign a random element from the remaining valid options
            if let chosenArrow = validChoices.randomElement() {
                directions.append(Arrow(direction: chosenArrow, active: true))
            } else {
                // Fallback catch-all (mathematically, at least 2 options will always be valid)
                directions.append(Arrow(direction: .up, active: true))
            }
        }
    }
    
    
}

// 3 + 2 + 1 = 5

// row=2
// col=1
// index=5
// size=3

// 5..4..3
