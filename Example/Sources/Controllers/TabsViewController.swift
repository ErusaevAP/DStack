//
//  TabsViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//

import DStack

final
class TabsViewController: DSTabsViewController<HeaderView> {

    private
    let ctrl2: DSTemplateViewController<WelcomeView> = {
        let ctrl = DSTemplateViewController<WelcomeView>()
        ctrl.title = "Welcome View"
        return ctrl
    }()

    private
    let ctrl3 = Example3ViewController()

    private
    let ctrl4 = CollectionViewController()

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
