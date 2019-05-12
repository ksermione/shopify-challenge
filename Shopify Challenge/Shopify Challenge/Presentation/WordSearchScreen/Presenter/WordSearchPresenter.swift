//
//  WordSearchPresenter.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 10.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import Foundation

class WordSearchPresenter {

    weak var viewController: WordSearchViewController?

    let words = [ "Swift", "Kotlin", "ObjectiveC", "Mobile", "Variable", "Java" ]

    func updateView() {
        let model = BoardModel.create(withWords: words, boardSize: 10)
        let vm = WordSearchViewModel(letters: model.letters, boardSize: model.boardSize)

        viewController?.updateView(withViewModel: vm)
    }
}

extension WordSearchPresenter: WordSearchViewControllerDelegate {
    func viewDidLoad() {
        updateView()
    }

    func didSelectWord(_ word: String) {
        words.forEach({ w in
            if word.uppercased() == w.uppercased() {
                viewController?.saveSelection()
                return
            }
        })
        viewController?.removeSelection()
    }

    func didPressStartNew() {
        updateView()
    }
}
