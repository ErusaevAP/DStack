//
//  TabsWithHeaderViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import DStack
import UIKit

class TabsWithHeaderViewController: DStack.TabsViewController<HeaderView, TabsBarView> {

    // MARK: Initialization

    init() {
        super.init(
            headerView: HeaderView(),
            viewControllers: [
                TabsViewController(),
                CollectionViewController(),
                CollectionViewControllerSmall(),
                Example1ViewController(),
                Example2ViewController()
            ]
        )
        title = "Tabs + Header"
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
