//
//  TabsViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import DStack
import UIKit
import RxCocoa
import RxSwift

class TabsViewController: DStack.TabsViewController<HeaderView> {

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

    private
    var disposeBag: DisposeBag?

    // MARK: Overrided Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        let disposeBag = DisposeBag()
        Observable<Int>.interval(2.0, scheduler: MainScheduler.instance).subscribe { [weak self] _ in
            self?.disposeBag = nil
            self?.viewControllers = [
                CollectionViewController(),
                CollectionViewController()
            ]
        }.disposed(by: disposeBag)
        self.disposeBag = disposeBag
    }

    override
    func buildTabsBarView() -> UIView? {
        return TabsBarView()
    }

}
