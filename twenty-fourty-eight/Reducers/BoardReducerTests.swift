//
//  BoardReducerTests.swift
//  twenty-fourty-eightTests
//
//  Created by Phil Vargas on 7/13/22.
//

import ComposableArchitecture
@testable import twenty_fourty_eight
import XCTest

class BoardFlowTests: XCTestCase {
    static let initialMatrix: BoardMatrix = [
        [0, 0, 2, 2],
        [4, 0, 4, 128],
        [0, 0, 0, 0],
        [4, 16, 8, 128],
    ]
    let store = TestStore(initialState: BoardState(matrix: initialMatrix), reducer: boardReducer, environment: .mock)

    func testSwipeDirectionFlow() {
        store.send(.swipe(.right)) {
            $0.matrix = [
                [0, 0, 0, 4],
                [0, 0, 8, 128],
                [0, 0, 0, 0],
                [4, 16, 8, 128],
            ]
        }
        store.receive(.addNewTile) {
            $0.newestTile = (1, 1)
        }
        store.send(.swipe(.down)) {
            $0.matrix = [
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 4],
                [4, 16, 16, 256],
            ]
        }
        store.receive(.addNewTile)
        store.send(.swipe(.left)) {
            $0.matrix = [
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [4, 0, 0, 0],
                [4, 32, 256, 0],
            ]
        }
        store.receive(.addNewTile)
        store.send(.swipe(.up)) {
            $0.matrix = [
                [8, 32, 256, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
            ]
        }
        store.receive(.addNewTile)
    }

    func testSwipeDoesNotAddNewTileWithNoChangesFlow() {
        store.send(.swipe(.right)) {
            $0.matrix = [
                [0, 0, 0, 4],
                [0, 0, 8, 128],
                [0, 0, 0, 0],
                [4, 16, 8, 128],
            ]
        }
        store.receive(.addNewTile) {
            $0.newestTile = self.store.environment.randomEmptyTile($0.matrix)
        }
        store.send(.swipe(.right))

        // by sending the action again, we confirm there was no effect emitting from the previous action
        // TODO: is there an actual way of asserting this?
        store.send(.swipe(.right))
    }
}
