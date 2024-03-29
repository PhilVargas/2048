//
//  GameState.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/15/22.
//

import ComposableArchitecture

struct GameStack: Equatable {
    let matrix: BoardMatrix
    let score: Int
}

struct GameState: Equatable {
    var board: BoardState
    var score: Int
    var alert: AlertState<GameAction>?
    var gameStack: [GameStack]

    init(board: BoardState = BoardState(), score: Int = 0, alert: AlertState<GameAction>? = nil, gameStack: [GameStack] = []) {
        self.board = board
        self.score = score
        self.alert = alert
        self.gameStack = gameStack
    }
}

extension AlertState where Action == GameAction {
    static func gameOverAlert(with score: Int) -> AlertState<GameAction> {
        AlertState(
            title: .init("Game Over!"),
            message: .init("Your Score: \(score)!"),
            dismissButton: .default(.init("New Game"), action: .send(.gameOverAlertDismissTapped))
        )
    }

    static func newGameAlert() -> AlertState<GameAction> {
        AlertState(
            title: .init("Are you sure you want to start a new game?"),
            primaryButton: .default(.init("Confirm"), action: .send(.newGameAlertConfirmTapped)),
            secondaryButton: .cancel(.init("Cancel"))
        )
    }
}
