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
    var randomEmptyTile: (_ matrix: BoardMatrix) -> TileCoordinate?
}

extension BoardEnvironment {
    static let live = BoardEnvironment(
        generateNewTileValue: BoardUtils.generateNewTileValue,
        randomEmptyTile: BoardUtils.randomEmptyTile
    )
    static let mock = BoardEnvironment(
        generateNewTileValue: { 0 },
        randomEmptyTile: { _ in (1, 1) }
    )
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
        if let emptyTileCoordinate = env.randomEmptyTile(state.matrix) {
            state.matrix[emptyTileCoordinate.row][emptyTileCoordinate.column] = env.generateNewTileValue()
            state.newestTile = emptyTileCoordinate
        }

        return Just(.checkGameOver).eraseToEffect()

    case .checkGameOver:
        return .none
    }
}
