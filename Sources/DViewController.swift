//
//  DViewController.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/16/17.
//
//

import UIKit

open
class DViewController<View: UIView>: UIViewController {

    let contentView = View()

    open override
    func viewDidLoad() {
        super.viewDidLoad()

        contentView
            .addInRootView(view)
            .fill()
    }

}
