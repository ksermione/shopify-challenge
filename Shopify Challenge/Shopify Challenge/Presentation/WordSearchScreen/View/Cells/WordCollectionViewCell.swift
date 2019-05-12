//
//  WordCollectionViewCell.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 12.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import Foundation
import UIKit

class WordCollectionViewCell: UICollectionViewCell {

    static let cellId = "WordCollectionViewCellId"

    @IBOutlet weak var wordLabel: UILabel!

    // MARK: overrides
    override func prepareForReuse() {
        wordLabel.text = nil
        wordLabel.attributedText = nil
    }

    func fill(withWord word: String) {
        wordLabel.text = word.uppercased()
    }

    func setFound() {
        guard let text = wordLabel.text else { return }
        let attributedString: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        wordLabel.attributedText = attributedString
    }
}
