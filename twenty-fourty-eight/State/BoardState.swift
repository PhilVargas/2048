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

    init(matrix: BoardMatrix = BoardState.emptyBoardMatrix()) {
        self.matrix = matrix
    }

    static func emptyBoardMatrix() -> BoardMatrix {
        return Array(repeating: Array(repeating: 0, count: 4), count: 4)
    }
}
