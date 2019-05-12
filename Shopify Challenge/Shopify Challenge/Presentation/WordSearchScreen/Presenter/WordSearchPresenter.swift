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
    var countOfFound = 0

    func updateView() {
        let model = BoardModel.create(withWords: words, boardSize: 10)
        let vm = WordSearchViewModel(letters: model.letters, boardSize: model.boardSize, words: words)

        viewController?.updateView(withViewModel: vm)
        updateCounter()
    }

    private func updateCounter() {
        viewController?.updateCounter(toCount: "\(countOfFound)/\(words.count)")
    }
}

extension WordSearchPresenter: WordSearchViewControllerDelegate {
    func viewDidLoad() {
        updateView()
    }

    func didSelectWord(_ word: String) {
        words.forEach({ w in
            if word.uppercased() == w.uppercased() {
                viewController?.saveSelection(forWord: word)
                countOfFound += 1
                updateCounter()
                return
            }
        })
        viewController?.removeSelection()
    }

    func didPressStartNew() {
        updateView()
        countOfFound = 0
        updateCounter()
    }
}
