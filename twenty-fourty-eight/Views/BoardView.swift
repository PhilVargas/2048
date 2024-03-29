//
//  BoardView.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

import ComposableArchitecture
import SwiftUI

struct BoardView: View {
    let store: Store<BoardState, BoardAction>

    @State private var animationToggle = false

    var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                ForEach(0 ..< viewStore.matrix.count, id: \.self) { row in
                    HStack {
                        ForEach(0 ..< viewStore.matrix[row].count, id: \.self) { column in
                            TileView(viewStore.matrix[row][column])
                                .animation((row, column) == viewStore.newestTile ? .easeIn : .none, value: animationToggle)
                        }
                    }
                    .padding(0)
                }
            }
            .padding(8)
            .background(Color.boardBackground)
            .cornerRadius(4)
            .gesture(
                DragGesture(minimumDistance: 24, coordinateSpace: .local)
                    .swipe { direction in
                        self.animationToggle.toggle()
                        viewStore.send(.swipe(direction))
                    }
            )
            .onAppear {
                viewStore.send(.addNewTile)
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        let board = [
            [0, 2, 4, 8],
            [16, 32, 64, 128],
            [256, 512, 1024, 2048],
            [5096, 0, 0, 0],
        ]
        let store = Store(initialState: BoardState(matrix: board), reducer: boardReducer, environment: .live)
        BoardView(store: store)
    }
}
