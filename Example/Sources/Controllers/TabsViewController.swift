//
//  TabsViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import DStack
import UIKit

class TabsViewController: DStack.TabsViewController<HeaderView, TabsBarView> {

    // MARK: Initialization

    init() {
        super.init(
            viewControlles: [
                CollectionViewController(),
                CollectionViewControllerSmall(),
                Example1ViewController(),
                Example2ViewController()
            ]
        )
        title = "Tabs"
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
