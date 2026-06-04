//
//  Game.swift
//  CustomView
//
//  Created by Muhammad on 04/06/26.
//

import SwiftUI

@Observable
class Game {
    var directions: [ArrowDirection] = []
    
    init() {
        collectRandomArrow(for: 3)
        print("Class \(directions.count)")
    }
    
    private func collectRandomArrow(for size: Int) {
        let length = ((size*size) - size) - 1
        directions = Array(repeating: ArrowDirection.allCases.randomElement()!, count: size*size)
        for i in 0..<length {
            if i % size == 0 {
                continue
            }
            
            directions[i] = getHValidArrow(for: directions[i+1])
            directions[i+size] = getHValidArrow(for: directions[i])
        }
    }
    
    func getHValidArrow(for arrow: ArrowDirection) -> ArrowDirection {
        switch arrow {
        case .right:
            let temp = ArrowDirection.allCases.randomElement()!
            if temp == .left {
                return getHValidArrow(for: arrow)
            } else {
                return temp
            }
        case .down:
            let temp = ArrowDirection.allCases.randomElement()!
            if temp == .up {
                return getHValidArrow(for: arrow)
            } else {
                return temp
            }
        default:
            return arrow
        }
    }
    
    
    // To Do
    func getVValidArrow(for arrow: ArrowDirection) -> ArrowDirection {
        let temp = ArrowDirection.allCases.randomElement()!
        
        if arrow
    }
}
