//
//  BoardUtilsTests.swift
//  twenty-fourty-eightTests
//
//  Created by Phil Vargas on 7/13/22.
//

import XCTest
@testable import twenty_fourty_eight

class BoardUtilsTests: XCTestCase {
    func testSlide() {
        let initialRow = [2, 0, 4, 0]
        let expectedRow = [0, 0, 2, 4]
        XCTAssertEqual(BoardUtils.slide(initialRow), expectedRow)
    }

    func testSlideReducedRow() {
        let initialRow = [2, 4, 0]
        let expectedRow = [0, 0, 2, 4]
        XCTAssertEqual(BoardUtils.slide(initialRow), expectedRow)
    }

    func testMergeNone() {
        let initialRow = [2, 4, 8, 16]
        let expectedRow = [2, 4, 8, 16]
        XCTAssertEqual(BoardUtils.merge(initialRow), expectedRow)
    }

    func testMergeNoneWithZeros() {
        let initialRow = [0, 2, 4, 2]
        let expectedRow = [0, 2, 4, 2]
        XCTAssertEqual(BoardUtils.merge(initialRow), expectedRow)
    }

    func testMergePairs() {
        let initialRow = [0, 0, 2, 2]
        let expectedRow = [0, 0, 4]
        XCTAssertEqual(BoardUtils.merge(initialRow), expectedRow)
    }

    func testMergePairsMiddle() {
        let initialRow = [0, 2, 2, 16]
        let expectedRow = [0, 4, 16]
        XCTAssertEqual(BoardUtils.merge(initialRow), expectedRow)
    }

    func testMergePairsEnd() {
        let initialRow = [2, 2, 4, 16]
        let expectedRow = [4, 4, 16]
        XCTAssertEqual(BoardUtils.merge(initialRow), expectedRow)
    }

    func testMergeTriplets() {
        let initialRow = [0, 4, 2, 2]
        let expectedRow = [0, 4, 4]
        XCTAssertEqual(BoardUtils.merge(initialRow), expectedRow)
    }

    func testMergeTripletsEnd() {
        let initialRow = [4, 2, 2, 16]
        let expectedRow = [4, 4, 16]
        XCTAssertEqual(BoardUtils.merge(initialRow), expectedRow)
    }

    func testMergeQuads() {
        let initialRow = [2, 2, 2, 2]
        let expectedRow = [4, 4]
        XCTAssertEqual(BoardUtils.merge(initialRow), expectedRow)
    }

    func testRotate() {
        let initialBoard = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
            [13, 14, 15, 16]
        ]
        let expectedBoard = [
            [13, 9, 5, 1],
            [14, 10, 6, 2],
            [15, 11, 7, 3],
            [16, 12, 8, 4]
        ]
        XCTAssertEqual(BoardUtils.rotate(initialBoard), expectedBoard)
    }

    func testRotate180() {
        let initialBoard = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
            [13, 14, 15, 16]
        ]
        let expectedBoard = [
            [16, 15, 14, 13],
            [12, 11, 10, 9],
            [8, 7, 6, 5],
            [4, 3, 2, 1]
        ]
        XCTAssertEqual(BoardUtils.rotate(BoardUtils.rotate(initialBoard)), expectedBoard)
    }

    func testRotate270() {
        let initialBoard = [
            [1, 2, 3, 4],
            [5, 6, 7, 8],
            [9, 10, 11, 12],
            [13, 14, 15, 16]
        ]
        let expectedBoard = [
            [4, 8, 12, 16],
            [3, 7, 11, 15],
            [2, 6, 10, 14],
            [1, 5, 9, 13]
        ]
        XCTAssertEqual(BoardUtils.rotate(BoardUtils.rotate(BoardUtils.rotate(initialBoard))), expectedBoard)
    }

    func testSwipe() {
        let initialBoard = [
            [0, 0, 2, 2],
            [0, 4, 4, 8],
            [0, 0, 0, 0],
            [16, 32, 64, 128]
        ]
        let expectedBoard = [
            [0, 0, 0, 4],
            [0, 0, 8, 8],
            [0, 0, 0, 0],
            [16, 32, 64, 128]
        ]
        XCTAssertEqual(BoardUtils.swipe(initialBoard, to: .right), expectedBoard)
    }

}
