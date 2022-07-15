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
            $0.newGameAlert = AlertState(title: .init("Are you sure you want to start a new game?"), primaryButton: .default(.init("Confirm"), action: .send(.newGameAlertConfirmTapped)), secondaryButton: .cancel(.init("Cancel")))
        }
        store.send(.newGameAlertCancelTapped) {
            $0.newGameAlert = nil
        }
        store.send(.newGameTapped) {
            $0.newGameAlert = AlertState(title: .init("Are you sure you want to start a new game?"), primaryButton: .default(.init("Confirm"), action: .send(.newGameAlertConfirmTapped)), secondaryButton: .cancel(.init("Cancel")))
        }
        store.send(.newGameAlertConfirmTapped) {
            $0.newGameAlert = nil
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
            $0.gameOverAlert = AlertState(title: .init("Game Over!"), message: .init("Your Score: \($0.score)!"), dismissButton: .default(.init("New Game")))
        }
        store.send(.gameOverAlertDismissTapped) {
            $0.gameOverAlert = nil
            $0 = GameState()
        }
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (1, 1)
        }
        store.receive(.board(.checkGameOver))
    }
}
