//
//  ContainerCell.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/21/17.
//
//

import UIKit

class ContainerCell: UICollectionViewCell {

    // MARK: Properties

    static
    let reuseIdentifier = "ContainerCell"

    var model: UIViewController? {
        didSet {
            oldValue?.view.removeFromSuperview()
            if let view = model?.view {
                view
                    .add(inRootView: contentView)
                    .fill()
            }
        }
    }

    // MARK: Initialization

    override
    init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.backgroundColor = .red
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
