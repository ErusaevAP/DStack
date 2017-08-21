//
//  HeaderView.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/17/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import DStack
import UIKit

class HeaderView: FlexibleHeader {

    // MARK: Properties

    private lazy var miniHeader: UILabel = {
        let v = UILabel()
        v.text = "Mini Header"
        v.textAlignment = .center
        v.alpha = 0
        return v
    }()

    private let backgroundImageView: UIImageView = {
        let v = UIImageView(image: UIImage(named: "header_image"))
        v.contentMode = .scaleAspectFill
        return v
    }()

    override
    var maxHeight: CGFloat {
        return 120
    }

    override
    var minHeight: CGFloat {
        return 44
    }

    // MARK: Initialization

    override
    init() {
        super.init()

        backgroundImageView
            .add(inRootView: self)
            .fill()

        miniHeader
            .add(inRootView: self)
            .setWidth()
            .setSize(height: minHeight)
            .setTopAlignment()
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()

        let alpha = (frame.size.height - minHeight) / (maxHeight - minHeight)
        backgroundImageView.alpha = alpha
        miniHeader.alpha = 1 - alpha
    }

}
