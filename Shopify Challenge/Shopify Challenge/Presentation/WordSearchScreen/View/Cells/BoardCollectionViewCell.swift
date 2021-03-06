//
//  BoardCollectionViewCell.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 10.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import Foundation
import UIKit

class BoardCollectionViewCell: UICollectionViewCell, UIGestureRecognizerDelegate {

    static let cellId = "BoardCollectionViewCellId"
    var state: BoardCellState = .unselected

    // colors
    let unselectedColor: UIColor = UIColor(red:0.93, green:0.93, blue:0.93, alpha:1.0)
    let selectedColor: UIColor = UIColor(red:0.64, green:0.64, blue:0.64, alpha:1.0)
    let foundColor: UIColor = UIColor(red:0.60, green:0.74, blue:0.25, alpha:1.0)

    @IBOutlet weak var letterLabel: UILabel!

    // MARK: overrides
    override func prepareForReuse() {
        letterLabel.text = nil
        backgroundColor = unselectedColor
        state = .unselected
    }

    func fill(withLetter letter: Character) {
        letterLabel.text = String(letter).uppercased()
    }

    func setState(to state: BoardCellState) {
        self.state = state
        
        switch state {
        case .unselected: backgroundColor = unselectedColor
        case .selected: backgroundColor = selectedColor
        case .found: backgroundColor = foundColor
        }
    }

    func getLetter() -> String? {
        if state == .unselected {
            return letterLabel.text
        }
        return nil
    }
}

enum BoardCellState {
    case unselected
    case selected
    case found
}
