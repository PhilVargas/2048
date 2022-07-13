//
//  BoardView.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

import SwiftUI
import ComposableArchitecture

struct BoardView: View {
    let store: Store<BoardState, BoardAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                ForEach(0..<viewStore.matrix.count, id: \.self) { row in
                    HStack {
                        ForEach(0..<viewStore.matrix[row].count, id: \.self) { column in
                            TileView(viewStore.matrix[row][column])
                        }
                    }
                    .padding(4)
                }
            }
            .padding(8)
            .background(Color.boardBackground)
            .cornerRadius(4)
        }
    }

}


struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        let board = [
            [0, 2, 4, 8],
            [16, 32, 64, 128],
            [256, 512, 1024, 2048],
            [5096, 0, 0, 0]
        ]
        let store = Store(initialState: BoardState(matrix: board), reducer: boardReducer, environment: .init())
        BoardView(store: store)
    }
}
