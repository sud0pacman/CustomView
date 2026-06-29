//
//  Game.swift
//  CustomView
//
//  Created by Muhammad on 04/06/26.
//

import Foundation

@Observable
class Game {
    var grid: [Arrow] = []
    private(set) var size: Int

    init(size: Int = 4) {
        self.size = size
        self.grid = Self.buildGrid(size: size)
    }

    // MARK: - Puzzle Generation

    private static func buildGrid(size: Int) -> [Arrow] {
        var cells = Array(repeating: Optional<ArrowDirection>.none, count: size * size)
        let indices = Array(0..<size*size).shuffled()
        for i in indices {
            let valid = ArrowDirection.allCases.filter { dir in
                cells[i] = dir
                let canGo = pathIsClear(cells: cells, index: i, size: size)
                cells[i] = nil
                return canGo
            }
            guard let chosen = valid.randomElement() else { continue }
            cells[i] = chosen
        }
        let filled = cells.filter { $0 != nil }.count
        if filled < max(4, size * size / 2) {
            return buildGrid(size: size)   // retry
        }
        return cells.map { dir in
            Arrow(direction: dir ?? .right, isOnBoard: dir != nil)
        }
    }

    private static func pathIsClear(cells: [ArrowDirection?], index: Int, size: Int) -> Bool {
        guard let dir = cells[index] else { return false }
        let r = index / size
        let c = index % size
        switch dir {
        case .up:
            for rr in stride(from: r - 1, through: 0, by: -1) {
                if cells[rr * size + c] != nil { return false }
            }
        case .down:
            for rr in (r + 1)..<size {
                if cells[rr * size + c] != nil { return false }
            }
        case .left:
            for cc in stride(from: c - 1, through: 0, by: -1) {
                if cells[r * size + cc] != nil { return false }
            }
        case .right:
            for cc in (c + 1)..<size {
                if cells[r * size + cc] != nil { return false }
            }
        }
        return true
    }

    // MARK: - Game Logic
    func canEscape(at index: Int) -> Bool {
        guard grid.indices.contains(index), grid[index].isOnBoard else { return false }
        let cells = grid.map { $0.isOnBoard ? Optional($0.direction) : nil }
        return Self.pathIsClear(cells: cells, index: index, size: size)
    }

    @discardableResult
    func tap(at index: Int) -> Bool {
        guard canEscape(at: index) else { return false }
        grid[index].isOnBoard = false
        return true
    }

    func newGame(size: Int? = nil) {
        let newSize = size ?? self.size
        let newGrid = Self.buildGrid(size: newSize)
        // Single assignment — SwiftUI sees one consistent update
        self.size = newSize
        self.grid = newGrid
    }

    var isCleared: Bool { grid.allSatisfy { !$0.isOnBoard } }
    var remaining: Int { grid.filter { $0.isOnBoard }.count }
}
