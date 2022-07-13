//
//  BoardUtils.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

class BoardUtils {

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
    static func rotate(_ matrix: BoardMatrix) -> BoardMatrix {
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
            return rotate(rotate(rotate(swipe(rotate(matrix)))))
        case .left:
            return rotate(rotate(swipe(rotate(rotate(matrix)))))
        case .down:
            return rotate(swipe(rotate(rotate(rotate(matrix)))))
        }
    }
}

