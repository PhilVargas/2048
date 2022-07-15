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
    .init { _, action, _ in
        switch action {
        case .board:
            return .none
        case .menuButtonTapped:
            return .none
        case .newGameTapped:
            return .none
        }
    }
)
