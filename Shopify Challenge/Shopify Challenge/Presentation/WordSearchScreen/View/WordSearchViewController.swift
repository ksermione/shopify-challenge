//
//  WordSearchViewController.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 10.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import Foundation
import UIKit

protocol WordSearchViewControllerDelegate {
    func viewDidLoad()
    func didSelectWord(_ word: String)
    func didPressStartNew()
}

class WordSearchViewController: UIViewController {

    @IBOutlet weak var boardCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var boardCollectionViewWidth: NSLayoutConstraint!
    @IBOutlet weak var boardCollectionView: UICollectionView!
    @IBOutlet weak var wordsCollectionView: UICollectionView!
    @IBOutlet weak var counterLabel: UILabel! { didSet { counterLabel.text = nil } }

    var delegate: WordSearchViewControllerDelegate?
    fileprivate var viewModel = WordSearchViewModel(letters: [[]], boardSize: 0, words: [])
    private var selectedWord: String = ""
    fileprivate var maxCollectionViewWidth: CGFloat = 0.0

    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewDidLoad()

        boardCollectionView.delegate = self
        boardCollectionView.dataSource = self

        wordsCollectionView.delegate = self
        wordsCollectionView.dataSource = self

        maxCollectionViewWidth = UIScreen.main.bounds.width
        boardCollectionViewHeight.constant = maxCollectionViewWidth
        boardCollectionViewWidth.constant = maxCollectionViewWidth

        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        boardCollectionView.addGestureRecognizer(gestureRecognizer)
    }

    // MARK: Actions
    
    @IBAction func didPressStartNew(_ sender: Any) {
        delegate?.didPressStartNew()
    }

    @objc func handlePan(gestureRecognizer: UIPanGestureRecognizer) {
        let currentLocation = gestureRecognizer.location(in: boardCollectionView)
        let section = getRow(y: currentLocation.y)
        let item = getColumn(x: currentLocation.x)
        let currentIndexPath = IndexPath(item: item, section: section)

        trySetSelectedState(forIndexPath: currentIndexPath)

        if gestureRecognizer.state == .ended {
            didSelectWord()
        }
    }
    
    func updateView(withViewModel model: WordSearchViewModel) {
        viewModel = model
        boardCollectionView.reloadData()
        wordsCollectionView.reloadData()
    }

    func saveSelection(forWord word: String) {
        for c in boardCollectionView.subviews {
            if let cell = c as? BoardCollectionViewCell,
                cell.state == .selected {
                cell.setState(to: .found)
            }
        }
        for c in wordsCollectionView.subviews {
            if let cell = c as? WordCollectionViewCell,
                let w = cell.wordLabel.text,
                w == word {
                cell.setFound()
            }
        }
    }

    func removeSelection() {
        for c in boardCollectionView.subviews {
            if let cell = c as? BoardCollectionViewCell,
                cell.state == .selected {
                cell.setState(to: .unselected)
            }
        }
    }

    func updateCounter(toCount count: String) {
        counterLabel.text = count
    }

    private func trySetSelectedState(forIndexPath indexPath: IndexPath) {
        if let cell = boardCollectionView.cellForItem(at: indexPath) as? BoardCollectionViewCell,
            let letter = cell.getLetter() {
            cell.setState(to: .selected)
            selectedWord += letter
        }
    }

    private func getRow(y: CGFloat) -> Int {
        let cellHeight = boardCollectionView.bounds.height / CGFloat(viewModel.boardSize)
        let rrr = Int((y / cellHeight).rounded(.down))
        return rrr
    }

    private func getColumn(x: CGFloat) -> Int {
        let cellWidth = boardCollectionView.bounds.width / CGFloat(viewModel.boardSize)
        let rrr = Int((x / cellWidth).rounded(.down))
        return rrr
    }

    private func didSelectWord() {
        delegate?.didSelectWord(selectedWord)
        selectedWord = ""
    }
}

extension WordSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionView == boardCollectionView ? viewModel.boardSize : 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == boardCollectionView ? viewModel.boardSize : viewModel.words.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == boardCollectionView,
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.cellId, for: indexPath) as? BoardCollectionViewCell {
            cell.fill(withLetter: viewModel.getLetter(forIndexPath: indexPath))
            return cell
        }
        else if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WordCollectionViewCell.cellId, for: indexPath) as? WordCollectionViewCell {
            cell.fill(withWord: viewModel.getWord(forIndexPath: indexPath))
            return cell
        }
        return UICollectionViewCell()
    }
}

// Sizes

extension WordSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width / ( collectionView == boardCollectionView ? CGFloat(viewModel.boardSize) : 2.0 )
        let height: CGFloat = collectionView == boardCollectionView ? width : 20.0
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView == boardCollectionView ? 0.0 : 15.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
