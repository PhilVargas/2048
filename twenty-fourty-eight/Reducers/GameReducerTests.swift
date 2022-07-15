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
    static let initialMatrix: BoardMatrix = [
        [0, 0, 2, 2],
        [4, 0, 4, 128],
        [0, 0, 0, 0],
        [4, 16, 8, 128],
    ]
    let store = TestStore(initialState: GameState(board: BoardState(matrix: initialMatrix)), reducer: gameReducer, environment: .mock)
    func testNewGameFlow() {
        store.send(.newGameTapped) {
            $0.alert = AlertState(title: .init("Are you sure you want to start a new game?"), primaryButton: .default(.init("Confirm"), action: .send(.newGameAlertConfirmTapped)), secondaryButton: .cancel(.init("Cancel")))
        }
        store.send(.newGameAlertCancelTapped) {
            $0.alert = nil
        }
        store.send(.newGameTapped) {
            $0.alert = AlertState(title: .init("Are you sure you want to start a new game?"), primaryButton: .default(.init("Confirm"), action: .send(.newGameAlertConfirmTapped)), secondaryButton: .cancel(.init("Cancel")))
        }
        store.send(.newGameAlertConfirmTapped) {
            $0.alert = nil
            $0 = GameState()
        }
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (1, 1)
        }
    }
}
