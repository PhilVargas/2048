//
//  BoardReducerTests.swift
//  twenty-fourty-eightTests
//
//  Created by Phil Vargas on 7/13/22.
//

import XCTest
import ComposableArchitecture
@testable import twenty_fourty_eight

class BoardFlowTests: XCTestCase {
    static let initialMatrix: BoardMatrix = [
        [0, 0, 2, 2],
        [4, 0, 4, 128],
        [0, 0, 0, 0],
        [4, 16, 8, 128]
    ]
    let store = TestStore(initialState: BoardState(matrix: initialMatrix), reducer: boardReducer, environment: BoardEnvironment())

    func testSwipeFlow() {
        self.store.send(.swipeRight) {
            $0.matrix = [
                [0, 0, 0, 4],
                [0, 0, 8, 128],
                [0, 0, 0, 0],
                [4, 16, 8, 128]
            ]
        }
        self.store.send(.swipeDown) {
            $0.matrix = [
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 4],
                [4, 16, 16, 256]
            ]
        }
        self.store.send(.swipeLeft) {
            $0.matrix = [
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [4, 0, 0, 0],
                [4, 32, 256, 0]
            ]
        }
        self.store.send(.swipeUp) {
            $0.matrix = [
                [8, 32, 256, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ]
        }
    }
}
