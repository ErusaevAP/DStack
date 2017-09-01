//
//  TabsViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import DStack
import UIKit

class TabsViewController: DStack.TabsViewController<HeaderView> {

    // MARK: Initialization

    init() {
        super.init(
            viewControllers: [
                ctrl1,
                ctrl3
            ]
        )
        title = "Tabs"
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrided Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "2",
            style: .done,
            target: self,
            action: #selector(tap2)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "4",
            style: .done,
            target: self,
            action: #selector(tap4)
        )
    }

    override
    func buildTabsBarView() -> UIView? {
        return TabsBarView()
    }

    // MARK: Actions

    private let ctrl1 = Example1ViewController()
    private let ctrl2 = Example2ViewController()
    private let ctrl3 = Example3ViewController()
    private let ctrl4 = CollectionViewController()

    @objc private
    func tap2() {
        viewControllers = [
            ctrl1,
            ctrl3
        ]
    }

    @objc private
    func tap4() {
        viewControllers = [
            ctrl1,
            ctrl2,
            ctrl3,
            ctrl4
        ]
    }

}
