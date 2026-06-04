//
//  Arrow.swift
//  CustomView
//
//  Created by Muhammad on 04/06/26.
//

struct Arrow {
    var direction: ArrowDirection
}

enum ArrowDirection: String, CaseIterable {
    case up
    case down
    case left
    case right
    
    var image: String {
        switch self {
        case .up: return "arrow.up"
        case .down: return "arrow.down"
        case .left: return "arrow.left"
        case .right: return "arrow.right"
        }
    }
}
