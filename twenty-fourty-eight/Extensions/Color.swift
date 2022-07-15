//
//  Color.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

import SwiftUI

// MARK: UI Colors

extension Color {
    static var boardBackground: Color {
        .init(red: 194 / 255, green: 178 / 255, blue: 154 / 255)
    }

    static var neutral: Color {
        .init(red: 250 / 255, green: 248 / 255, blue: 239 / 255)
    }

    enum ButtonColor {
        case primary
        case secondary
    }

    static func buttonBackground(_ bgColor: ButtonColor) -> Color {
        switch bgColor {
        case .primary: return .init(red: 188 / 255, green: 172 / 255, blue: 159 / 255)
        case .secondary: return .init(red: 143 / 255, green: 122 / 255, blue: 101 / 255)
        }
    }

    static func textColor(_ bgColor: ButtonColor) -> Color {
        switch bgColor {
        case .primary: return .init(red: 120 / 255, green: 111 / 255, blue: 102 / 255)
        case .secondary: return .white
        }
    }
}

// MARK: Tile Colors

extension Color {
    static var tileEmpty: Color {
        .init(red: 238 / 255, green: 228 / 255, blue: 218 / 255, opacity: 0.35)
    }

    static var tileTwo: Color {
        .init(red: 238 / 255, green: 228 / 255, blue: 218 / 255)
    }

    static var tileFour: Color {
        .init(red: 237 / 255, green: 224 / 255, blue: 200 / 255)
    }

    static var tileEight: Color {
        .init(red: 242 / 255, green: 177 / 255, blue: 121 / 255)
    }

    static var tileSixteen: Color {
        .init(red: 245 / 255, green: 149 / 255, blue: 99 / 255)
    }

    static var tileThirtyTwo: Color {
        .init(red: 246 / 255, green: 124 / 255, blue: 95 / 255)
    }

    static var tileSixtyFour: Color {
        .init(red: 246 / 255, green: 94 / 255, blue: 59 / 255)
    }

    static var tileOneTwentyEight: Color {
        .init(red: 237 / 255, green: 207 / 255, blue: 114 / 255)
    }

    static var tileTwoFiftySix: Color {
        .init(red: 237 / 255, green: 204 / 255, blue: 97 / 255)
    }

    static var tileFiveTwelve: Color {
        .init(red: 237 / 255, green: 200 / 255, blue: 80 / 255)
    }

    static var tileTenTwentyFour: Color {
        .init(red: 237 / 255, green: 197 / 255, blue: 63 / 255)
    }

    static var tileTwentyFourtyEight: Color {
        .init(red: 237 / 255, green: 194 / 255, blue: 46 / 255)
    }

    static var tileMax: Color {
        .black
    }
}
