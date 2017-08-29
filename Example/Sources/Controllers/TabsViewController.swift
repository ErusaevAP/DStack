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
            viewControllers: [
                CollectionViewController(),
                CollectionViewController()
            ]
        )
        title = "Tabs"
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
