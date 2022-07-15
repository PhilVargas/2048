//
//  GameReducerTests.swift
//  twenty-fourty-eightTests
//
//  Created by Phil Vargas on 7/15/22.
//

import ComposableArchitecture
@testable import twenty_fourty_eight
import XCTest

class GameFlowTests: XCTestCase {
    let initialMatrix: BoardMatrix = [
        [0, 0, 2, 2],
        [4, 0, 4, 128],
        [0, 0, 0, 0],
        [4, 16, 8, 128],
    ]
    let gameOverMatrix = [
        [2, 4, 2, 4],
        [4, 2, 4, 2],
        [2, 4, 2, 4],
        [4, 2, 4, 2],
    ]

    func testNewGameFlow() {
        let store = TestStore(initialState: GameState(board: BoardState(matrix: initialMatrix)), reducer: gameReducer, environment: .mock)

        store.send(.newGameTapped) {
            $0.alert = store.state.newGameAlert()
        }
        store.send(.alertDismissTapped) {
            $0.alert = nil
        }
        store.send(.newGameTapped) {
            $0.alert = store.state.newGameAlert()
        }
        store.send(.newGameAlertConfirmTapped) {
            $0.alert = nil
            $0 = GameState()
        }
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (1, 1)
        }
        store.receive(.board(.checkGameOver))
    }

    func testCheckGameOverFlow() {
        let store = TestStore(initialState: GameState(board: BoardState(matrix: gameOverMatrix)), reducer: gameReducer, environment: .mock)

        store.send(.board(.checkGameOver)) {
            $0.alert = store.state.gameOverAlert()
        }
        store.send(.gameOverAlertDismissTapped) {
            $0.alert = nil
            $0 = GameState()
        }
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (1, 1)
        }
        store.receive(.board(.checkGameOver))
    }

    func testScoreFlow() {
        let store = TestStore(initialState: GameState(board: BoardState(matrix: initialMatrix)), reducer: gameReducer, environment: .mock)
        store.send(.board(.swipe(.right))) {
            $0.board.matrix = [
                [0, 0, 0, 4],
                [0, 0, 8, 128],
                [0, 0, 0, 0],
                [4, 16, 8, 128],
            ]
        }
        store.receive(.board(.tallyScore(4 + 8))) {
            $0.score += 4 + 8
        }
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (1, 1)
        }
        store.receive(.board(.checkGameOver))
    }
}
