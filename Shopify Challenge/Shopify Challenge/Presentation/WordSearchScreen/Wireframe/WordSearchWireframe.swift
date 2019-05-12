//
//  WordSearchWireframe.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 10.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import Foundation
import UIKit

class WordSearchWireframe {

    class func assemble() -> UIViewController {
        let storyBoard = UIStoryboard(name: "WordSearchStoryboard", bundle: Bundle.main)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "WordSearchViewControllerId") as! WordSearchViewController
        let presenter = WordSearchPresenter()
        presenter.viewController = viewController
        viewController.delegate = presenter

        return viewController
    }
}
