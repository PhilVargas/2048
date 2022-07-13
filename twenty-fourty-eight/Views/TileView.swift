//
//  TileView.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/13/22.
//

import SwiftUI

struct TileView: View {
    let value: Int
    private let title: String
    private let style: TileViewStyle

    init(_ value: Int) {
        self.value = value
        self.title = value == 0 ? "" : value.description
        self.style = .init(value)
    }

    var body: some View {
        Text(title)
            .font(.system(size: style.fontSize, weight: .black, design: .rounded))
            .foregroundColor(.white)
            .frame(width: 70, height: 70)
            .background(style.backgroundColor)
            .cornerRadius(3)
            .animation(.easeIn, value: 1)
    }
}

enum TileViewStyle {
    case empty
    case two
    case four
    case eigth
    case sixteen
    case thirtyTwo
    case sixtyFour
    case oneTwentyEight
    case twoFiftySix
    case fiveTwelve
    case tenTwentyFour
    case twentyFourtyEight
    case max

    init(_ value: Int) {
        switch value {
        case 0: self = .empty
        case 2: self = .two
        case 4: self = .four
        case 8: self = .eigth
        case 16: self = .sixteen
        case 32: self = .thirtyTwo
        case 64: self = .sixtyFour
        case 128: self = .oneTwentyEight
        case 256: self = .twoFiftySix
        case 512: self = .fiveTwelve
        case 1024: self = .tenTwentyFour
        case 2048: self = .twentyFourtyEight
        default: self = .max
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .oneTwentyEight, .twoFiftySix, .fiveTwelve:
            return 28
        case .tenTwentyFour, .twentyFourtyEight, .max:
            return 22
        default:
            return 30
        }
    }

    var backgroundColor: Color {
        switch self {
        case .empty: return .tileEmpty
        case .two: return .tileTwo
        case .four: return .tileFour
        case .eigth: return .tileEight
        case .sixteen: return .tileSixteen
        case .thirtyTwo: return .tileThirtyTwo
        case .sixtyFour: return .tileSixtyFour
        case .oneTwentyEight: return .tileOneTwentyEight
        case .twoFiftySix: return .tileTwoFiftySix
        case .fiveTwelve: return .tileFiveTwelve
        case .tenTwentyFour: return .tileTenTwentyFour
        case .twentyFourtyEight: return .tileTwentyFourtyEight
        case .max: return .tileMax
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TileView(0)
            TileView(2)
            TileView(64)
            TileView(512)
            TileView(2048)
            TileView(5096)
        }
    }
}
