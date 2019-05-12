//
//  WordSearchViewModel.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 11.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import Foundation

struct WordSearchViewModel {
    var letters: [[Character?]]
    var boardSize: Int
    var words: [String]
}

extension WordSearchViewModel {
    func getLetter(forIndexPath indexPath: IndexPath) -> Character {
        return letters[indexPath.section][indexPath.item] ?? Character.random()
    }

    func getWord(forIndexPath indexPath: IndexPath) -> String {
        return words[indexPath.item]
    }
}
