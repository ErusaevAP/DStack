//
//  CollectionViewCell.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit
import DStack

class CollectionViewCell: UICollectionViewCell {

    // MARK: Properties

    static
    let reuseIdentifier = "CollectionViewCell"

    // MARK: Subviews

    private
    let label = UILabel()

    var model: String? {
        didSet {
            label.text = model
        }
    }

    // MARK: Initialization

    override
    init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .white
        label.textAlignment = .center
        label
            .add(inRootView: contentView)
            .fill()
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
