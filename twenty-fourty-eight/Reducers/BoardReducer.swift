//
//  BoardReducer.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

import ComposableArchitecture

struct BoardEnvironment {
    public init() {}
}

let boardReducer = Reducer<BoardState, BoardAction, BoardEnvironment> { state, action, _ in
    switch action {
    case .swipeRight:
        print("swiped!")
    }

    return .none
}
