//
//  GameActions.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/15/22.
//

enum GameAction: Equatable {
    case board(BoardAction)

    case menuButtonTapped
    case newGameTapped
    case newGameAlertConfirmTapped
    case gameOverAlertDismissTapped
    case newGameAlertCancelTapped
}
