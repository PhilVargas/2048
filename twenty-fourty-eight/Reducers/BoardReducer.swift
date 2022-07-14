//
//  BoardReducer.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

import Combine
import ComposableArchitecture

struct BoardEnvironment {
    var generateNewTileValue: () -> Int
}

extension BoardEnvironment {
    static let live = BoardEnvironment(generateNewTileValue: BoardUtils.generateNewTileValue)
    static let mock = BoardEnvironment(generateNewTileValue: { 0 })
}

let boardReducer = Reducer<BoardState, BoardAction, BoardEnvironment> { state, action, env in
    switch action {
    case let .swipe(direction):
        let initialMatrix = state.matrix
        state.matrix = BoardUtils.swipe(state.matrix, to: direction)
        if state.matrix == initialMatrix {
            return .none
        }
        return Just(.addNewTile).eraseToEffect()

    case .addNewTile:
        if let emptyTileCoordinate = BoardUtils.randomEmptyTile(state.matrix) {
            state.matrix[emptyTileCoordinate.row][emptyTileCoordinate.column] = env.generateNewTileValue()
        }
    }

    return .none
}
