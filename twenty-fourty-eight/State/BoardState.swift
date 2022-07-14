//
//  BoardState.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

import Foundation

typealias BoardRow = [Int]
typealias BoardMatrix = [BoardRow]
typealias TileCoordinate = (row: Int, column: Int)

struct BoardState: Equatable {
    var matrix: BoardMatrix
    var newestTile: TileCoordinate?

    init(matrix: BoardMatrix = BoardState.emptyBoardMatrix(), newestTile: TileCoordinate? = nil) {
        self.matrix = matrix
        self.newestTile = newestTile
    }

    static func emptyBoardMatrix() -> BoardMatrix {
        return Array(repeating: Array(repeating: 0, count: 4), count: 4)
    }
}

extension BoardState {
    static func == (lhs: BoardState, rhs: BoardState) -> Bool {
        lhs.matrix == rhs.matrix &&
            lhs.newestTile == rhs.newestTile
    }
}
