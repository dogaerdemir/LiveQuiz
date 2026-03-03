//
//  OptionLabel.swift
//  flashquiz
//

import Foundation

enum OptionLabel {
    static func short(_ index: Int) -> String {
        guard let scalar = UnicodeScalar(65 + index) else {
            return "?"
        }

        return "\(Character(scalar))"
    }

    static func prefixed(_ index: Int) -> String {
        "\(short(index)))"
    }
}
