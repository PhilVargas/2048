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
                state.alert = state.gameOverAlert()
            }
            return .none
        case let .board(.tallyScore(points)):
            state.score += points
            return .none
        case .board:
            return .none
        case .menuButtonTapped:
            return .none
        case .newGameTapped:
            state.alert = state.newGameAlert()

            return .none
        case .alertDismissTapped:
            state.alert = nil

            return .none
        case .newGameAlertConfirmTapped, .gameOverAlertDismissTapped:
            state = GameState()
            return Just(GameAction.board(.addNewTile)).eraseToEffect()
        }
    }
)
