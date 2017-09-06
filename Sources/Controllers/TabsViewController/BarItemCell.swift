//
//  BarItemCell.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/21/17.
//
//

import UIKit

class BarItemCell: UICollectionViewCell {

    // MARK: Properties

    static
    let reuseIdentifier = "BarItemCell"

    var model: String? {
        didSet {
            label.text = model
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    private
    let label = UILabel()

    // MARK: Initialization

    override
    init(frame: CGRect) {
        super.init(frame: .zero)

        contentView.backgroundColor = .green
        label
            .add(inRootView: contentView)
            .fill(marge: 5)
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
