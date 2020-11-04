//
//  TabsViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//

import DStack
import UIKit

@objcMembers
class TabsViewController: DSTabsViewController<HeaderView> {

    // MARK: Properties

    private
    let ctrl2 = DSTemplateViewController<WelcomelView>()

    private
    let ctrl3 = Example3ViewController()

    private
    let ctrl4 = CollectionViewController()

    // MARK: Initialization

    init() {
        super.init(
            viewControllers: []
        )
        title = "Tabs"
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrided Methods

    override
    func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        viewControllers = [ctrl4, ctrl2]
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                title: "2 tabs",
                style: .done,
                target: self,
                action: #selector(on2Tapped)
            ),
            UIBarButtonItem(
                title: "3 tabs",
                style: .done,
                target: self,
                action: #selector(on3Tapped)
            )
        ]
    }

    // MARK: Actions

    @objc private
    func on2Tapped() {
        viewControllers = [
            ctrl4,
            ctrl2
        ]
    }

    @objc private
    func on3Tapped() {
        viewControllers = [
            ctrl2,
            ctrl3,
            ctrl4
        ]
    }

}
