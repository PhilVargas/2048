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
        case .board:
            return .none
        case .menuButtonTapped:
            return .none
        case .newGameTapped:
            state.alert = AlertState(
                title: .init("Are you sure you want to start a new game?"),
                primaryButton: .default(.init("Confirm"), action: .send(.newGameAlertConfirmTapped)),
                secondaryButton: .cancel(.init("Cancel"))
            )

            return .none
        case .newGameAlertCancelTapped:
            state.alert = nil

            return .none
        case .newGameAlertConfirmTapped:
            state = GameState()
            return Just(GameAction.board(.addNewTile)).eraseToEffect()
        }
    }
)
