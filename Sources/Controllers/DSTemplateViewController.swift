//
//  DSTemplateViewController.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/16/17.
//
//

import UIKit

open
class DSTemplateViewController<View: UIView>: UIViewController {

    // MARK: Properties

    public
    let contentView: View

    // MARK: Initialization

    public
    init(contentView: View? = nil) {
        self.contentView = contentView ?? View()
        super.init(nibName: nil, bundle: nil)
    }

    public required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle

    open override
    func viewDidLoad() {
        super.viewDidLoad()

        contentView
            .add(inRootView: view)
            .fill()
    }

}
