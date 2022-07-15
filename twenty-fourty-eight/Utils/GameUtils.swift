//
//  GameUtils.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/15/22.
//

enum GameUtils {
    static func isGameOver(_ matrix: BoardMatrix) -> Bool {
        return BoardUtils.randomEmptyTile(matrix) == nil &&
            BoardUtils.swipe(matrix, to: .right) == matrix &&
            BoardUtils.swipe(matrix, to: .left) == matrix &&
            BoardUtils.swipe(matrix, to: .up) == matrix &&
            BoardUtils.swipe(matrix, to: .down) == matrix
    }
}
