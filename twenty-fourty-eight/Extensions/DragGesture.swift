//
//  View.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/25/22.
//

import SwiftUI

extension DragGesture {
    func swipe(_ action: @escaping (SwipeDirection) -> Void) -> _EndedGesture<Self> {
        onEnded { value in
            let hDelta = value.translation.width
            let vDelta = value.translation.height
            let direction: SwipeDirection

            if abs(hDelta) > abs(vDelta) {
                direction = hDelta < 0 ? .left : .right
            } else {
                direction = vDelta < 0 ? .up : .down
            }

            action(direction)
        }
    }
}
