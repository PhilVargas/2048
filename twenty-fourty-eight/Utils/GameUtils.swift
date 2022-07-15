//
//  GameUtils.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/15/22.
//

enum GameUtils {
    static func isGameOver(_ matrix: BoardMatrix) -> Bool {
        return BoardUtils.randomEmptyTile(matrix) == nil &&
            BoardUtils(matrix).swipe(.right) == matrix &&
            BoardUtils(matrix).swipe(.left) == matrix &&
            BoardUtils(matrix).swipe(.up) == matrix &&
            BoardUtils(matrix).swipe(.down) == matrix
    }
}
