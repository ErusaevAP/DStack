//
//  Example1ViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/2/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit
import DStack

class Example1ViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        label1.addInRootView(view)
            .set(width: 50, height: 50)
            .setTopAnchor(anchor: topLayoutGuide.bottomAnchor)
            .setLeftAnchor(rootView: view)

        label2.addInRootView(view)
            .set(width: 50, height: 50)
            .setTopAnchor(anchor: topLayoutGuide.bottomAnchor)
            .setRightAnchor(rootView: view)

        label3.addInRootView(view)
            .set(width: 50, height: 50)
            .setBottomAnchor(anchor: bottomLayoutGuide.topAnchor)
            .setRightAnchor(rootView: view)

        label4.addInRootView(view)
            .set(width: 50, height: 50)
            .setBottomAnchor(anchor: bottomLayoutGuide.topAnchor)
            .setLeftAnchor(rootView: view)

        label5.addInRootView(view)
            .set(width: 50, height: 50)
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
