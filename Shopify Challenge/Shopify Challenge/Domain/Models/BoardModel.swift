//
//  BoardModel.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 10.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import Foundation

struct BoardModel {
    var letters: [[Character?]]
    var boardSize: Int

    init(letters: [[Character?]], boardSize: Int) {
        self.letters = letters
        self.boardSize = boardSize
    }
}

extension BoardModel {
    static func create(withWords words: [String], boardSize: Int) -> BoardModel {

        // empty board
        var letters = [[Character?]]()
        for _ in 0...(boardSize - 1) {
            var strRow = [Character?]()
            for _ in 0...(boardSize - 1) {
                strRow.append(nil)
            }
            letters.append(strRow)
        }

        words.forEach({ w in
            if w.count <= boardSize {
                let word = w.uppercased()
                let maxStart = (boardSize - word.count)

                var positionX = maxStart > 0 ? Int.random(in: 0..<(maxStart)) : 0
                var positionY = Int.random(in: 0..<(boardSize))

                while !canPlaceHorizontally(word: word, positionX: positionX, positionY: positionY, letters: letters) {
                    positionX = maxStart > 0 ? Int.random(in: 0..<(maxStart)) : 0
                    positionY = Int.random(in: 0..<(boardSize))
                }

                // place horizontally
                word.forEach({ char in
                    letters[positionY][positionX] = char
                    positionX += 1
                })
            }
        })
        return BoardModel(letters: letters, boardSize: boardSize)
    }

    static private func canPlaceHorizontally(word: String, positionX: Int, positionY: Int, letters: [[Character?]]) -> Bool {
        var posX = positionX
        var canPlace = true
        word.forEach({ char in
            if (letters[positionY][posX] != nil) {
                if (letters[positionY][posX] != char) {
                    canPlace = false
                    return
                }
            }
            posX += 1
        })
        return canPlace
    }
}

enum Direction {
    case down
    case right
}
