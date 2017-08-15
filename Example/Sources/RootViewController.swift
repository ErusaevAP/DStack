//
//  RootViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/11/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private
    var contentViewController: UIViewController? {
        didSet {
            oldValue?.willMove(toParentViewController: nil)
            oldValue?.view.removeFromSuperview()
            oldValue?.removeFromParentViewController()

            if let contentViewController = contentViewController {
                addChildViewController(contentViewController)
                view.addSubview(contentViewController.view)

                contentViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                contentViewController.view.frame = view.bounds
                contentViewController.didMove(toParentViewController: self)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentViewController = MainViewController()
    }

}
