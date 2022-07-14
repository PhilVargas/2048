//
//  BoardUtils.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

class BoardUtils {

    static func generateNewTileValue() -> Int {
        (Array(repeating: 2, count: 9) + [4]).randomElement()!
    }

    static func randomEmptyTile(_ matrix: BoardMatrix) -> TileCoordinate? {
        zeroCoordinates(matrix).randomElement()
    }

    private static func zeroCoordinates(_ matrix: BoardMatrix) ->  [TileCoordinate] {
        var coordinates: [(TileCoordinate)] = []
        for i in 0..<matrix.count {
            for j in 0..<matrix[i].count {
                if matrix[i][j] == 0 {
                    coordinates.append((i, j))
                }
            }
        }

        return coordinates
    }

    static func slide(_ row: BoardRow) -> BoardRow {
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
    static func merge(_ row: BoardRow, index: Int = 0) -> BoardRow {
        let nextIndex = index + 1
        if nextIndex >= row.endIndex { return row }

        var newRow: BoardRow = row.reversed()
        let first = row.reversed()[index]
        let second = row.reversed()[nextIndex]
        if first == second && first > 0 {
            newRow[index] = first + second
            newRow.remove(at: nextIndex)
        }
        return merge(newRow.reversed(), index: nextIndex)
    }

    // Rotate matrix clockwise by 90 degrees
    static func rotateClockwise(_ matrix: BoardMatrix) -> BoardMatrix {
        let n = matrix.count
        var newBoard = matrix

        for i in (0..<n/2) {
            var j = i
            while j < n - i - 1 {
                let swap = newBoard[i][j]
                newBoard[i][j] = newBoard[n - 1 - j][i]
                newBoard[n - 1 - j][i] = newBoard[n - 1 - i][n - 1 - j]
                newBoard[n - 1 - i][n - 1 - j] = newBoard[j][n - 1 - i]
                newBoard[j][n - 1 - i] = swap

                j += 1
            }
        }

        return newBoard
    }

    // Rotate matrix clockwise by 180 degrees
    static func flip(_ matrix: BoardMatrix) -> BoardMatrix {
        rotateClockwise(rotateClockwise(matrix))
    }

    // Rotate matrix counter clockwise 90 degrees, or clockwise by 270 degrees
    static func rotateCounterClockwise(_ matrix: BoardMatrix) -> BoardMatrix {
        rotateClockwise(rotateClockwise(rotateClockwise(matrix)))
    }

    private static func swipe(_ matrix: BoardMatrix) -> BoardMatrix {
       matrix.map(slide)
            .map { row in merge(row) }
            .map(slide)
    }

    static func swipe(_ matrix: BoardMatrix, to direction: SwipeDirection) -> BoardMatrix {
        switch direction {
        case .right:
           return swipe(matrix)
        case .up:
            return rotateCounterClockwise(swipe(rotateClockwise(matrix)))
        case .left:
            return flip(swipe(flip(matrix)))
        case .down:
            return rotateClockwise(swipe(rotateCounterClockwise(matrix)))
        }
    }
}

