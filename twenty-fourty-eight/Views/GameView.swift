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
        var isUndoDisabled: Bool

        init(state: GameState) {
            score = state.score
            isUndoDisabled = state.gameStack.count == .zero
        }
    }

    enum ViewAction {
        case menuButtonTapped
        case newGameTapped
        case undo
    }

    @State var aboutMe = false

    var body: some View {
        WithViewStore(self.store.scope(state: ViewState.init, action: GameAction.init)) { viewStore in
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Text("2048")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                        .foregroundColor(.textColor(.primary))

                    VStack {
                        VStack {
                            Text("Score")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .padding(.top, 4)

                            Text("\(viewStore.score)")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .scaledToFit()
                                .minimumScaleFactor(0.5)
                                .padding(.horizontal, 30)
                                .padding(.bottom, 4)
                        }
                        .frame(width: 160, height: 55, alignment: .center)
                        .fixedSize()
                        .background(Color.buttonBackground(.primary))
                        .cornerRadius(4)
                        HStack {
                            Button("Undo") {
                                viewStore.send(.undo)
                            }
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .background(viewStore.isUndoDisabled ? Color.buttonBackground(.primary) : Color.buttonBackground(.secondary))
                            .cornerRadius(4)
                            .disabled(viewStore.isUndoDisabled)

                            Button("New Game") {
                                viewStore.send(.newGameTapped)
                            }
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .padding(.init(top: 8, leading: 8, bottom: 8, trailing: 8))
                            .background(Color.buttonBackground(.secondary))
                            .cornerRadius(4)
                            .alert(
                                self.store.scope(state: \.alert), dismiss: .alertDismissTapped
                            )
                        }.frame(minWidth: 160)
                    }.foregroundColor(.textColor(.secondary))
                }
                .frame(maxWidth: 360)

                Text("Join the numbers and get to the **2048** tile!")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundColor(.textColor(.primary))

                BoardView(store: self.store.scope(state: \.board, action: GameAction.board))

                Spacer()

                Button(action: {
                    self.aboutMe = true
                }, label: {
                    Text("About Me").frame(maxWidth: UIScreen.main.bounds.width - 100)
                })
                .buttonStyle(.borderedProminent)
                .tint(Color.buttonBackground(.secondary))
                .buttonBorderShape(.capsule)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundColor(.textColor(.secondary))
                .sheet(isPresented: $aboutMe) {
                    AboutView()
                }
            }
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
        case .undo:
            self = .undo
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
