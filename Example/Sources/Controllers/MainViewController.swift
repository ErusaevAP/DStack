//
//  MainViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/2/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit

// MARK: -

class MainViewController: UITabBarController {

    // MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)

        setViewControllers(
            [
                TabsViewController().navigationController,
                TabsWithHeaderViewController().navigationController,
                Example1ViewController().navigationController,
                Example2ViewController().navigationController,
                Example3ViewController().navigationController
            ],
            animated: false
        )
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: -

private
extension UIViewController {

    var navigationController: UINavigationController {
        return UINavigationController(rootViewController: self)
    }

}
