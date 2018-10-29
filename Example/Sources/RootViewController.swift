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
            oldValue?.willMove(toParent: nil)
            oldValue?.view.removeFromSuperview()
            oldValue?.removeFromParent()

            if let contentViewController = contentViewController {
                addChild(contentViewController)
                view.addSubview(contentViewController.view)

                contentViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                contentViewController.view.frame = view.bounds
                contentViewController.didMove(toParent: self)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contentViewController = MainViewController()
    }

}
