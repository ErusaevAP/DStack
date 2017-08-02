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

    override
    func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let stackView = UIStackView()
            .addInRootView(view)
            .setTopAnchor(anchor: topLayoutGuide.bottomAnchor)
            .setRightAnchor(anchor: view.rightAnchor)
            .setBottomAnchor(anchor: bottomLayoutGuide.topAnchor)
            .setLeftAnchor(anchor: view.leftAnchor)

        let side: CGFloat = 70

        label1.addInRootView(stackView)
            .setSize(width: side, height: side)
            .setTopAlignment()
            .setCenterX()

        label2.addInRootView(stackView)
            .setSize(width: side, height: side)
            .setRightAlignment()
            .setCenterY()

        label3.addInRootView(stackView)
            .setSize(width: side, height: side)
            .setBottomAlignment()
            .setCenterX()

        label4.addInRootView(stackView)
            .setSize(width: side, height: side)
            .setLeftAlignment()
            .setCenterY()

        label5.addInRootView(stackView)
            .setSize(width: side, height: side)
            .setCenter()
    }

    // MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Example 3"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
