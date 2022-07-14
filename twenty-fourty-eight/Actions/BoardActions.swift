//
//  BoardActions.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

enum BoardAction: Equatable {
    case swipe(SwipeDirection)
    case addNewTile
}

enum SwipeDirection {
    case right
    case down
    case left
    case up // swiftlint:disable:this identifier_name
}
