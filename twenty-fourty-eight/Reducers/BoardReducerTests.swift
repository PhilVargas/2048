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

    let swipeRightMatrix = [
        [0, 0, 0, 4],
        [0, 0, 8, 128],
        [0, 0, 0, 0],
        [4, 16, 8, 128],
    ]
    let swipeDownMatrix = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 4],
        [4, 16, 16, 256],
    ]
    let swipeLeftMatrix = [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [4, 0, 0, 0],
        [4, 32, 256, 0],
    ]
    let swipeUpMatrix = [
        [8, 32, 256, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
    ]
    let swipeFinalRightMatrix = [
        [0, 8, 32, 256],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
    ]

    func testSwipeDirectionFlow() {
        let store = TestStore(initialState: BoardState(matrix: initialMatrix), reducer: boardReducer, environment: .mock)

        store.send(.swipe(.right)) {
            $0.matrix = self.swipeRightMatrix
        }
        store.receive(.recordGameState(initialMatrix))
        store.receive(.tallyScore(4 + 8))
        store.receive(.addNewTile) {
            $0.newestTile = (1, 1)
        }
        store.receive(.checkGameOver)
        store.send(.swipe(.down)) {
            $0.matrix = self.swipeDownMatrix
        }
        store.receive(.recordGameState(swipeRightMatrix))
        store.receive(.tallyScore(16 + 256))
        store.receive(.addNewTile)
        store.receive(.checkGameOver)
        store.send(.swipe(.left)) {
            $0.matrix = self.swipeLeftMatrix
        }
        store.receive(.recordGameState(swipeDownMatrix))
        store.receive(.tallyScore(32))
        store.receive(.addNewTile)
        store.receive(.checkGameOver)
        store.send(.swipe(.up)) {
            $0.matrix = self.swipeUpMatrix
        }
        store.receive(.recordGameState(swipeLeftMatrix))
        store.receive(.tallyScore(8))
        store.receive(.addNewTile)
        store.receive(.checkGameOver)
        store.send(.swipe(.right)) {
            $0.matrix = self.swipeFinalRightMatrix
        }
        store.receive(.recordGameState(swipeUpMatrix))
        store.receive(.tallyScore(0))
        store.receive(.addNewTile)
        store.receive(.checkGameOver)
    }

    func testSwipeDoesNotAddNewTileWithNoChangesFlow() {
        let store = TestStore(initialState: BoardState(matrix: initialMatrix), reducer: boardReducer, environment: .mock)
        store.send(.swipe(.right)) {
            $0.matrix = self.swipeRightMatrix
        }
        store.receive(.recordGameState(initialMatrix))
        store.receive(.tallyScore(4 + 8))
        store.receive(.addNewTile) {
            $0.newestTile = (1, 1)
        }
        store.receive(.checkGameOver)
        store.send(.swipe(.right))
    }

    func testSwipeGameOverWhenNoNewTileIsAdded() {
        let store = TestStore(initialState: BoardState(matrix: gameOverMatrix), reducer: boardReducer, environment: .mock)
        store.environment.randomEmptyTile = { _ in (0, 0) }
        store.environment.generateNewTileValue = { 2 }

        store.send(.swipe(.right)) {
            $0.matrix = [
                [0, 4, 2, 4],
                [4, 2, 4, 2],
                [2, 4, 2, 4],
                [4, 2, 4, 2],
            ]
        }
        store.receive(.recordGameState(gameOverMatrix))
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
