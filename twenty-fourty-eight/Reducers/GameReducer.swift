//
//  GameReducer.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/15/22.
//

import Combine
import ComposableArchitecture

struct GameEnvironment {
    var board: BoardEnvironment
}

extension GameEnvironment {
    static let live = GameEnvironment(board: .live)
    static let mock = GameEnvironment(board: .mock)
}

let gameReducer = Reducer<GameState, GameAction, GameEnvironment>.combine(
    boardReducer.pullback(state: \.board, action: /GameAction.board, environment: \.board),
    .init { state, action, _ in
        switch action {
        case .board(.checkGameOver):
            if GameUtils.isGameOver(state.board.matrix) {
                state.gameOverAlert = AlertState(
                    title: .init("Game Over!"),
                    message: .init("Your Score: \(state.score)!"),
                    dismissButton: .default(.init("New Game"))
                )
            }
            return .none
        case .board:
            return .none
        case .menuButtonTapped:
            return .none
        case .newGameTapped:
            state.newGameAlert = AlertState(
                title: .init("Are you sure you want to start a new game?"),
                primaryButton: .default(.init("Confirm"), action: .send(.newGameAlertConfirmTapped)),
                secondaryButton: .cancel(.init("Cancel"))
            )

            return .none
        case .newGameAlertCancelTapped:
            state.newGameAlert = nil

            return .none
        case .newGameAlertConfirmTapped, .gameOverAlertDismissTapped:
            state = GameState()
            return Just(GameAction.board(.addNewTile)).eraseToEffect()
        }
    }
)
