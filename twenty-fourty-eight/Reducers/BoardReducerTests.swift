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
    let initialMatrix: BoardMatrix = [
        [0, 0, 2, 2],
        [4, 0, 4, 128],
        [0, 0, 0, 0],
        [4, 16, 8, 128],
    ]

    let gameOverMatrix: BoardMatrix = [
        [4, 0, 2, 4],
        [4, 2, 4, 2],
        [2, 4, 2, 4],
        [4, 2, 4, 2],
    ]

    func testSwipeDirectionFlow() {
        let store = TestStore(initialState: BoardState(matrix: initialMatrix), reducer: boardReducer, environment: .mock)
        store.send(.swipe(.right)) {
            $0.matrix = [
                [0, 0, 0, 4],
                [0, 0, 8, 128],
                [0, 0, 0, 0],
                [4, 16, 8, 128],
            ]
        }
        store.receive(.tallyScore(4 + 8))
        store.receive(.addNewTile) {
            $0.newestTile = (1, 1)
        }
        store.receive(.checkGameOver)
        store.send(.swipe(.down)) {
            $0.matrix = [
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 4],
                [4, 16, 16, 256],
            ]
        }
        store.receive(.tallyScore(16 + 256))
        store.receive(.addNewTile)
        store.receive(.checkGameOver)
        store.send(.swipe(.left)) {
            $0.matrix = [
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [4, 0, 0, 0],
                [4, 32, 256, 0],
            ]
        }
        store.receive(.tallyScore(32))
        store.receive(.addNewTile)
        store.receive(.checkGameOver)
        store.send(.swipe(.up)) {
            $0.matrix = [
                [8, 32, 256, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
            ]
        }
        store.receive(.tallyScore(8))
        store.receive(.addNewTile)
        store.receive(.checkGameOver)
        store.send(.swipe(.right)) {
            $0.matrix = [
                [0, 8, 32, 256],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
            ]
        }
        store.receive(.tallyScore(0))
        store.receive(.addNewTile)
        store.receive(.checkGameOver)
    }

    func testSwipeDoesNotAddNewTileWithNoChangesFlow() {
        let store = TestStore(initialState: BoardState(matrix: initialMatrix), reducer: boardReducer, environment: .mock)
        store.send(.swipe(.right)) {
            $0.matrix = [
                [0, 0, 0, 4],
                [0, 0, 8, 128],
                [0, 0, 0, 0],
                [4, 16, 8, 128],
            ]
        }
        store.receive(.tallyScore(4 + 8))
        store.receive(.addNewTile) {
            $0.newestTile = store.environment.randomEmptyTile($0.matrix)
        }
        store.receive(.checkGameOver)
        store.send(.swipe(.right))
    }

    func testSwipeGameOverWhenNoNewTileIsAdded() {
        let store = TestStore(initialState: BoardState(matrix: gameOverMatrix), reducer: boardReducer, environment: .live)
        store.environment.generateNewTileValue = { 2 }

        store.send(.swipe(.right)) {
            $0.matrix = [
                [0, 4, 2, 4],
                [4, 2, 4, 2],
                [2, 4, 2, 4],
                [4, 2, 4, 2],
            ]
        }
        store.receive(.tallyScore(0))
        store.receive(.addNewTile) {
            $0.matrix = [
                [2, 4, 2, 4],
                [4, 2, 4, 2],
                [2, 4, 2, 4],
                [4, 2, 4, 2],
            ]
            $0.newestTile = (0, 0)
        }
        store.receive(.checkGameOver)
    }
}
