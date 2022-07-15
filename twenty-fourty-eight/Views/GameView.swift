//
//  GameView.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/15/22.
//

import ComposableArchitecture
import SwiftUI

struct GameView: View {
    let store: Store<GameState, GameAction>

    struct ViewState: Equatable {
        var score: Int

        init(state: GameState) {
            score = state.score
        }
    }

    enum ViewAction {
        case menuButtonTapped
        case newGameTapped
    }

    var body: some View {
        WithViewStore(self.store.scope(state: ViewState.init, action: GameAction.init)) { viewStore in
            VStack(spacing: 16) {
                HStack(spacing: 32) {
                    Spacer()
                    Text("2048")
                        .font(.system(size: 64, weight: .bold, design: .rounded))
                        .foregroundColor(.textColor(.primary))
                    VStack {
                        Text("Score")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding(.top, 4)

                        Text("9001")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .padding(.horizontal, 30)
                            .padding(.bottom, 4)
                    }
                    .background(Color.buttonBackground(.primary))
                    .foregroundColor(.textColor(.secondary))
                    .cornerRadius(4)
                    Spacer()
                }
                HStack {
                    HStack {
                        Text("Join the numbers and get to the **2048** tile!")
                    }
                    .foregroundColor(.textColor(.primary))
                    .font(.system(.caption, design: .rounded))

                    Button("New Game") {
                        viewStore.send(.newGameTapped)
                    }
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color.buttonBackground(.secondary))
                    .foregroundColor(.textColor(.secondary))
                    .cornerRadius(4)
                    .alert(
                        self.store.scope(state: \.alert), dismiss: .alertDismissTapped
                    )
                }
                BoardView(store: self.store.scope(state: \.board, action: GameAction.board))
                Spacer()
            }
            .background(Color.neutral)
            .navigationBarBackButtonHidden(true)
        }
    }
}

extension GameAction {
    init(action: GameView.ViewAction) {
        switch action {
        case .menuButtonTapped:
            self = .menuButtonTapped
        case .newGameTapped:
            self = .newGameTapped
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            let store = Store(initialState: GameState(), reducer: gameReducer, environment: .live)
            GameView(store: store)
        }
    }
}
