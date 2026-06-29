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
        self.grid = []
        generateSolvablePuzzle()
    }

    // MARK: - Puzzle Generation
    private func generateSolvablePuzzle() {
        var cells = Array(repeating: Optional<ArrowDirection>.none, count: size * size)
        var placementOrder: [Int] = []
        let indices = Array(0..<size*size).shuffled()

        for i in indices {
            // Which directions can escape from position i given cells already placed?
            let valid = ArrowDirection.allCases.filter { dir in
                cells[i] = dir
                let canGo = pathIsClear(cells: cells, index: i)
                cells[i] = nil
                return canGo
            }
            guard let chosen = valid.randomElement() else { continue }
            cells[i] = chosen
            placementOrder.insert(i, at: 0) // solution plays in reverse
        }

        // Require at least half the board filled
        let filled = cells.filter { $0 != nil }.count
        if filled < max(4, size * size / 2) {
            generateSolvablePuzzle()
            return
        }

        grid = cells.map { dir in
            Arrow(direction: dir ?? .right, isOnBoard: dir != nil)
        }
    }

    // MARK: - Game Logic

    /// Returns true if the arrow at `index` has a clear path to the edge in its direction.
    func canEscape(at index: Int) -> Bool {
        guard grid[index].isOnBoard else { return false }
        let cells = grid.map { $0.isOnBoard ? Optional($0.direction) : nil }
        return pathIsClear(cells: cells, index: index)
    }

    /// Core path-check that works on any cell snapshot (used during generation too).
    private func pathIsClear(cells: [ArrowDirection?], index: Int) -> Bool {
        guard let dir = cells[index] else { return false }
        let r = index / size
        let c = index % size

        switch dir {
        case .up:
            // Check every cell above in the same column
            for rr in stride(from: r - 1, through: 0, by: -1) {
                if cells[rr * size + c] != nil { return false }
            }
        case .down:
            for rr in (r + 1)..<size {
                if cells[rr * size + c] != nil { return false }
            }
        case .left:
            // Check every cell to the left in the same row
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

    /// Attempts to move (escape) the arrow at index. Returns whether it succeeded.
    @discardableResult
    func tap(at index: Int) -> Bool {
        guard canEscape(at: index) else { return false }
        grid[index].isOnBoard = false
        return true
    }

    func newGame(size: Int? = nil) {
        self.size = size ?? self.size
        generateSolvablePuzzle()
    }

    var isCleared: Bool {
        grid.allSatisfy { !$0.isOnBoard }
    }

    var remaining: Int {
        grid.filter { $0.isOnBoard }.count
    }
}
