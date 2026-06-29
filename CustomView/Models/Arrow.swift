// Arrow.swift
import Foundation

enum ArrowDirection: CaseIterable {
    case up, down, left, right
}

struct Arrow {
    var direction: ArrowDirection
    var isOnBoard: Bool = true  // false = escaped/removed
}

extension ArrowDirection {
    var glyph: String {
        switch self {
        case .up:    return "↑"
        case .down:  return "↓"
        case .left:  return "←"
        case .right: return "→"
        }
    }
}
