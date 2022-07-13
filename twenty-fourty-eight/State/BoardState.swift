//
//  BoardState.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

import Foundation

typealias BoardMatrix = [[Int]]

struct BoardState: Equatable {
    let matrix: BoardMatrix

    init(matrix: BoardMatrix = BoardState.emptyBoardMatrix()) {
        self.matrix = matrix
    }

    static func emptyBoardMatrix() -> BoardMatrix {
        return Array(repeating: Array(repeating: 0, count: 4), count: 4)
    }
}
