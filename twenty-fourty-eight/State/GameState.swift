//
//  GameState.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/15/22.
//

import ComposableArchitecture

struct GameState: Equatable {
    var board: BoardState
    var score: Int
    var newGameAlert: AlertState<GameAction>?
    var gameOverAlert: AlertState<GameAction>?

    init(board: BoardState = BoardState(), score: Int = 0, gameOverAlert: AlertState<GameAction>? = nil, newGameAlert: AlertState<GameAction>? = nil) {
        self.board = board
        self.score = score
        self.gameOverAlert = gameOverAlert
        self.newGameAlert = newGameAlert
    }
}
