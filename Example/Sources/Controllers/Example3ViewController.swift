//
//  Example3ViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/2/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit
import DStack

class Example3ViewController: UIViewController {

    // MARK: Properties

    private let makeLabel = { (title: String) -> UILabel in
        let label = UILabel()
        label.backgroundColor = .red
        label.text = title
        label.textAlignment = .center
        return label
    }

    // MARK: Subviews

    private lazy
    var label1: UILabel = self.makeLabel("1")

    private lazy
    var label2: UILabel = self.makeLabel("2")

    private lazy
    var label3: UILabel = self.makeLabel("3")

    private lazy
    var label4: UILabel = self.makeLabel("4")

    private lazy
    var label5: UILabel = self.makeLabel("5")

    // MARK: Life Cycle

    override
    func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let side: CGFloat = 100

        label1.addInRootView(view)
            .setSize(width: side, height: side)
            .setTopAlignment()
            .setLeftAlignment()

        label2.addInRootView(view)
            .setSize(width: side, height: side)
            .setTopAlignment()
            .setRightAlignment()

        label3.addInRootView(view)
            .setSize(width: side, height: side)
            .setBottomAlignment()
            .setRightAlignment()

        label4.addInRootView(view)
            .setSize(width: side, height: side)
            .setBottomAlignment()
            .setLeftAlignment()

        label5.addInRootView(view)
            .setSize(width: side, height: side)
            .setCenter()
    }

    // MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Example 1"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
