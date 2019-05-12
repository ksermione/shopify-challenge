//
//  Character+Extensions.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 12.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import Foundation

extension Character {
    static func random() -> Character {
        let chars = "abcdefghijklmnopqrstuvwxyz"
        return chars.randomElement()!
    }
}
