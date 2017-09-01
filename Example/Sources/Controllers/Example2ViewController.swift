//
//  Example2ViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/2/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit
import DStack

class Example2ViewController: UIViewController {

    // MARK: Properties

    private
    let makeLabel = { (title: String) -> UILabel in
        let l = UILabel()
        l.backgroundColor = .red
        l.text = title
        l.textAlignment = .center
        return l
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

        label1.add(inRootView: view)
            .setSize(width: side, height: side)
            .setTopAlignment()
            .setCenterX()

        label2.add(inRootView: view)
            .setSize(width: side, height: side)
            .setRightAlignment()
            .setCenterY()

        label3.add(inRootView: view)
            .setSize(width: side, height: side)
            .setBottomAlignment()
            .setCenterX()

        label4.add(inRootView: view)
            .setSize(width: side, height: side)
            .setLeftAlignment()
            .setCenterY()

        label5.add(inRootView: view)
            .setSize(width: side, height: side)
            .setCenter()
    }

    // MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Example Example"
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
