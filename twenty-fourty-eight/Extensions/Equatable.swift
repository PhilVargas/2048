//
//  Equatable.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/14/22.
//

// https://stackoverflow.com/a/33244957/3213605
func == <T: Equatable>(lhs: (T, T)?, rhs: (T, T)?) -> Bool {
    switch (lhs, rhs) {
    case let (.some(l), .some(r)): // swiftlint:disable:this identifier_name
        return l == r
    case (.none, .none):
        return true
    default:
        return false
    }
}
