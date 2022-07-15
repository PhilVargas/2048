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
    var alert: AlertState<GameAction>?

    init(board: BoardState = BoardState(), score: Int = 0, alert: AlertState<GameAction>? = nil) {
        self.board = board
        self.score = score
        self.alert = alert
    }
}
