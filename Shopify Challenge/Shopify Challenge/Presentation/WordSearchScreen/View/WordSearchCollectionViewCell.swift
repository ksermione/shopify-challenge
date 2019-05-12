//
//  WordSearchCollectionViewCell.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 10.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import Foundation
import UIKit

class WordSearchCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    static let cellId = "WordSearchCollectionViewCellId"
    var state: CellState = .unselected

    @IBOutlet weak var letterLabel: UILabel!

    func fill(withLetter letter: Character) {
        letterLabel.text = String(letter)
    }

    func setState(to state: CellState) {
        self.state = state
        
        switch state {
        case .unselected: backgroundColor = .white
        case .selected: backgroundColor = .lightGray
        case .found: backgroundColor = .green
        }
    }

    func getLetter() -> String? {
        if state == .unselected {
            return letterLabel.text
        }
        return nil
    }

    override func prepareForReuse() {
        letterLabel.text = nil
    }
}

enum CellState {
    case unselected
    case selected
    case found
}
