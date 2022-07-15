//
//  BoardUtils.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

class BoardUtils {
    let matrix: BoardMatrix
    var points = 0

    init(_ matrix: BoardMatrix) {
        self.matrix = matrix
    }

    static func generateNewTileValue() -> Int {
        (Array(repeating: 2, count: 9) + [4]).randomElement()!
    }

    static func randomEmptyTile(_ matrix: BoardMatrix) -> TileCoordinate? {
        zeroCoordinates(matrix).randomElement()
    }

    internal static func zeroCoordinates(_ matrix: BoardMatrix) -> [TileCoordinate] {
        var coordinates: [TileCoordinate] = []
        for row in 0 ..< matrix.count {
            for col in 0 ..< matrix[row].count {
                if matrix[row][col] == 0 {
                    coordinates.append((row, col))
                }
            }
        }

        return coordinates
    }

    internal func slide(_ row: BoardRow) -> BoardRow {
        let nonzeroRow = row.filter { value in value > 0 }
        let zeroPad = Array(repeating: 0, count: 4 - nonzeroRow.count)
        return zeroPad + nonzeroRow
    }

    // `slide` should have been run before this function is called.
    //
    // Take the current tile and the next tile, if they are equal,
    // then add them together and replace at the current tile's index.
    //
    // Once a tile has been merged, it cannot merge with another tile,
    // so we remove the tile at the next index and continue merging at
    // the new next index. This effectively skips the next-tile that was
    // merged into the current tile
    //
    // We end the merge when the current index is the last element of
    // the row, it has nothing to merge with behind it.
    internal func merge(_ row: BoardRow, index: Int = 0) -> BoardRow {
        let nextIndex = index + 1
        if nextIndex >= row.endIndex { return row }

        var newRow: BoardRow = row.reversed()
        let first = row.reversed()[index]
        let second = row.reversed()[nextIndex]
        if first == second, first > 0 {
            newRow[index] = first + second
            newRow.remove(at: nextIndex)
            points += first + second
        }
        return merge(newRow.reversed(), index: nextIndex)
    }

    // Rotate matrix clockwise by 90 degrees
    internal func rotateClockwise(_ matrix: BoardMatrix) -> BoardMatrix {
        let len = matrix.count
        var newBoard = matrix

        for row in 0 ..< len / 2 {
            var col = row
            while col < len - row - 1 {
                let swap = newBoard[row][col]
                newBoard[row][col] = newBoard[len - 1 - col][row]
                newBoard[len - 1 - col][row] = newBoard[len - 1 - row][len - 1 - col]
                newBoard[len - 1 - row][len - 1 - col] = newBoard[col][len - 1 - row]
                newBoard[col][len - 1 - row] = swap

                col += 1
            }
        }

        return newBoard
    }

    // Rotate matrix clockwise by 180 degrees
    internal func flip(_ matrix: BoardMatrix) -> BoardMatrix {
        rotateClockwise(rotateClockwise(matrix))
    }

    // Rotate matrix counter clockwise 90 degrees, or clockwise by 270 degrees
    internal func rotateCounterClockwise(_ matrix: BoardMatrix) -> BoardMatrix {
        rotateClockwise(rotateClockwise(rotateClockwise(matrix)))
    }

    internal func swipe(_ matrix: BoardMatrix) -> BoardMatrix {
        matrix.map(slide)
            .map { row in merge(row) }
            .map(slide)
    }

    func swipe(_ direction: SwipeDirection) -> BoardMatrix {
        let matrix: BoardMatrix
        switch direction {
        case .right:
            matrix = swipe(self.matrix)
        case .up:
            matrix = rotateCounterClockwise(swipe(rotateClockwise(self.matrix)))
        case .left:
            matrix = flip(swipe(flip(self.matrix)))
        case .down:
            matrix = rotateClockwise(swipe(rotateCounterClockwise(self.matrix)))
        }

        return matrix
    }
}
