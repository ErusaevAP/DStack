//
//  TabsWithHeaderViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//

import DStack
import UIKit

final
class TabsWithHeaderViewController: DSTabsViewController<HeaderView> {

    // MARK: Initialization

    init() {
        super.init(
            headerView: HeaderView(),
            viewControllers: [
                CollectionViewController(),
                CollectionViewControllerSmall(),
                TabsViewController()
            ]
        )
        title = "Tabs + Header"
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    override
    func viewDidLoad() {
        super.viewDidLoad()

        title = "TabsViewController + Header"
    }

    public
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.dsNavigationBar?.pushState(barState: .clear)
    }

    public
    override
    func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.dsNavigationBar?.popState()
    }

}
