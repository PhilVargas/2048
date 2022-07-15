//
//  GameUtilsTests.swift
//  twenty-fourty-eightTests
//
//  Created by Phil Vargas on 7/15/22.
//

@testable import twenty_fourty_eight
import XCTest

class GameUtilsTests: XCTestCase {
    let gameOverMatrix = [
        [2, 4, 2, 4],
        [4, 8, 4, 2],
        [2, 4, 2, 4],
        [4, 2, 4, 2],
    ]
    let swipeUpMatrix = [
        [2, 8, 2, 4],
        [4, 8, 4, 2],
        [2, 4, 2, 4],
        [4, 2, 4, 2],
    ]
    let swipeRightMatrix = [
        [2, 4, 2, 4],
        [4, 8, 8, 2],
        [2, 4, 2, 4],
        [4, 2, 4, 2],
    ]
    let swipeLeftMatrix = [
        [2, 4, 2, 4],
        [8, 8, 4, 2],
        [2, 4, 2, 4],
        [4, 2, 4, 2],
    ]
    let swipeDownMatrix = [
        [2, 4, 2, 4],
        [4, 8, 4, 2],
        [2, 8, 2, 4],
        [4, 2, 4, 2],
    ]
    let gameBoard = [
        [0, 0, 2, 2],
        [0, 4, 4, 8],
        [0, 0, 0, 0],
        [16, 32, 64, 128],
    ]
    func testIsGameOver() {
        XCTAssertFalse(GameUtils.isGameOver(swipeUpMatrix))
        XCTAssertFalse(GameUtils.isGameOver(swipeLeftMatrix))
        XCTAssertFalse(GameUtils.isGameOver(swipeRightMatrix))
        XCTAssertFalse(GameUtils.isGameOver(swipeDownMatrix))
        XCTAssertFalse(GameUtils.isGameOver(gameBoard))
        XCTAssertFalse(GameUtils.isGameOver(BoardState.emptyBoardMatrix()))
        XCTAssertTrue(GameUtils.isGameOver(gameOverMatrix))
    }
}
