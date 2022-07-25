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
        case let .board(.recordGameState(matrix)):
            var stack = state.gameStack.count == 10 ? Array(state.gameStack.dropFirst()) : state.gameStack

            stack.append(.init(matrix: matrix, score: state.score))
            state.gameStack = stack
            return .none
        case .board(.checkGameOver):
            if GameUtils.isGameOver(state.board.matrix) {
                state.alert = .gameOverAlert(with: state.score)
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
            state.alert = .newGameAlert()

            return .none
        case .alertDismissTapped:
            state.alert = nil

            return .none
        case .newGameAlertConfirmTapped, .gameOverAlertDismissTapped:
            state = GameState()
            return Just(GameAction.board(.addNewTile)).eraseToEffect()
        case .undo:
            if let previousSwipeState = state.gameStack.popLast() {
                state.board.matrix = previousSwipeState.matrix
                state.score = previousSwipeState.score
                state.board.newestTile = nil
            }

            return .none
        }
    }
)
