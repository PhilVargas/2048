//
//  BoardReducer.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

import ComposableArchitecture
import Combine

struct BoardEnvironment {
    public init() {}
}

let boardReducer = Reducer<BoardState, BoardAction, BoardEnvironment> { state, action, _ in
    switch action {
    case .swipe(let direction):
        state.matrix = BoardUtils.swipe(state.matrix, to: direction)
//        return Just(.addNewTile).eraseToEffect()

    case .addNewTile:
//        if let emptyTileCoordinate = BoardUtils.randomEmptyTile(state.matrix) {
//            state.matrix[emptyTileCoordinate.row][emptyTileCoordinate.column] = 2
//        }
    }


    return .none
}
