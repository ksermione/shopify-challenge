//
//  AppRouter.swift
//  Shopify Challenge
//
//  Created by Oksana Shcherban on 10.05.19.
//  Copyright © 2019 Oksana Shcherban. All rights reserved.
//

import UIKit

class AppRouter {

    var window: UIWindow?
    var mainController: WordSearchViewController?

    func presentRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let wordSearchVC = WordSearchWireframe.assemble()

        if let window = window, let mainVC = wordSearchVC as? WordSearchViewController {

            self.mainController = mainVC
            window.rootViewController = mainVC
            window.makeKeyAndVisible()
        }
    }
}
