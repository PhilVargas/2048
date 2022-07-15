//
//  GameState.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/15/22.
//

struct GameState: Equatable {
    var board: BoardState
    var score: Int

    init(board: BoardState = BoardState(), score: Int = 0) {
        self.board = board
        self.score = score
    }
}
