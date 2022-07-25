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
    let preGameOverMatrix = [
        [4, 2, 4, 0],
        [4, 2, 4, 2],
        [2, 4, 2, 4],
        [4, 2, 4, 2],
    ]
    let preGameOverSwipeMatrix = [
        [0, 4, 2, 4],
        [4, 2, 4, 2],
        [2, 4, 2, 4],
        [4, 2, 4, 2],
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
            $0.alert = .newGameAlert()
        }
        store.send(.alertDismissTapped) {
            $0.alert = nil
        }
        store.send(.newGameTapped) {
            $0.alert = .newGameAlert()
        }
        store.send(.newGameAlertConfirmTapped) {
            $0.alert = nil
            $0 = GameState()
        }
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (1, 1)
        }
    }

    func testCheckGameOverFlow() {
        let store = TestStore(initialState: GameState(board: BoardState(matrix: preGameOverMatrix)), reducer: gameReducer, environment: .mock)
        store.environment.board.randomEmptyTile = { _ in (0, 0) }
        store.environment.board.generateNewTileValue = { 2 }

        store.send(.board(.swipe(.right))) {
            $0.board.matrix = self.preGameOverSwipeMatrix
        }
        store.receive(.board(.recordGameState(preGameOverMatrix))) {
            $0.gameStack = [
                .init(matrix: self.preGameOverMatrix, score: 0),
            ]
        }
        store.receive(.board(.tallyScore(0)))
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (0, 0)
            $0.board.matrix = self.gameOverMatrix
        }

        store.send(.board(.swipe(.right)))
        store.receive(.board(.checkGameOver)) {
            $0.alert = .gameOverAlert(with: $0.score)
        }
        store.send(.gameOverAlertDismissTapped) {
            $0.alert = nil
            $0 = GameState()
        }
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (0, 0)
            $0.board.matrix = [
                [2, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
            ]
        }
    }

    func testCheckGameOverWithoutLosingFlow() {
        let store = TestStore(initialState: GameState(board: BoardState(matrix: preGameOverMatrix)), reducer: gameReducer, environment: .mock)
        store.environment.board.randomEmptyTile = { _ in (0, 0) }
        store.environment.board.generateNewTileValue = { 2 }

        store.send(.board(.swipe(.left)))
        store.receive(.board(.checkGameOver))
    }

    func testScoreFlow() {
        let store = TestStore(initialState: GameState(board: BoardState(matrix: initialMatrix)), reducer: gameReducer, environment: .mock)
        let expectedMatrix = [
            [0, 0, 0, 4],
            [0, 0, 8, 128],
            [0, 0, 0, 0],
            [4, 16, 8, 128],
        ]
        store.send(.board(.swipe(.right))) {
            $0.board.matrix = expectedMatrix
        }
        store.receive(.board(.recordGameState(initialMatrix))) {
            $0.gameStack = [
                .init(matrix: self.initialMatrix, score: 0),
            ]
        }
        store.receive(.board(.tallyScore(4 + 8))) {
            $0.score += 4 + 8
        }
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (1, 1)
        }
    }

    func testUndoFlow() {
        let store = TestStore(initialState: GameState(board: BoardState(matrix: initialMatrix)), reducer: gameReducer, environment: .mock)
        let expectedMatrix = [
            [0, 0, 0, 4],
            [0, 0, 8, 128],
            [0, 0, 0, 0],
            [4, 16, 8, 128],
        ]
        store.send(.board(.swipe(.right))) {
            $0.board.matrix = expectedMatrix
        }
        store.receive(.board(.recordGameState(initialMatrix))) {
            $0.gameStack = [
                .init(matrix: self.initialMatrix, score: 0),
            ]
        }
        store.receive(.board(.tallyScore(4 + 8))) {
            $0.score += 4 + 8
        }
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (1, 1)
        }

        store.send(.undo) {
            $0.board.matrix = self.initialMatrix
            $0.score = 0
            $0.board.newestTile = nil
            $0.gameStack = []
        }

        store.send(.undo)
    }

    func testGameStackMaxUndoFlow() {
        let initialMatrix = [
            [0, 0, 4, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]

        let swipeRightMatrix = [
            [0, 0, 0, 4],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]

        let swipeLeftMatrix = [
            [4, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
        ]

        let maxGameStack: [GameStack] = [
            .init(matrix: initialMatrix, score: 0),
            .init(matrix: swipeRightMatrix, score: 0),
            .init(matrix: swipeLeftMatrix, score: 0),
            .init(matrix: swipeRightMatrix, score: 0),
            .init(matrix: swipeLeftMatrix, score: 0),
            .init(matrix: swipeRightMatrix, score: 0),
            .init(matrix: swipeLeftMatrix, score: 0),
            .init(matrix: swipeRightMatrix, score: 0),
            .init(matrix: swipeLeftMatrix, score: 0),
        ]

        let store = TestStore(initialState: GameState(board: BoardState(matrix: swipeRightMatrix), gameStack: maxGameStack), reducer: gameReducer, environment: .mock)

        store.send(.board(.swipe(.left))) {
            $0.board.matrix = swipeLeftMatrix
        }
        store.receive(.board(.recordGameState(swipeRightMatrix))) {
            $0.gameStack.append(.init(matrix: swipeRightMatrix, score: 0))
        }
        store.receive(.board(.tallyScore(0)))
        store.receive(.board(.addNewTile)) {
            $0.board.newestTile = (1, 1)
        }

        store.send(.board(.swipe(.right))) {
            $0.board.matrix = swipeRightMatrix
        }
        store.receive(.board(.recordGameState(swipeLeftMatrix))) {
            $0.gameStack = Array($0.gameStack.dropFirst()) + [.init(matrix: swipeLeftMatrix, score: 0)]
        }
        store.receive(.board(.tallyScore(0)))
        store.receive(.board(.addNewTile))
    }
}
