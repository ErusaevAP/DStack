//
//  HeaderView.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/17/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import DStack
import UIKit

class HeaderView: DSFlexibleHeader {

    // MARK: Properties

    override
    var maxHeight: CGFloat {
        button.isSelected ? 160 : 260
    }

    override
    var minHeight: CGFloat {
        120
    }

    private
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("Big Header", for: .normal)
        button.setTitle("Small Header", for: .selected)
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        return button
    }()

    // MARK: Suviews

    private lazy
    var miniHeader: UILabel = {
        let label = UILabel()
        label.text = "Mini Header"
        label.textAlignment = .center
        label.alpha = 0
        return label
    }()

    private
    let backgroundImageView: UIImageView = {
        let image = UIImage(named: "header_image")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()

    // MARK: Initialization

    override
    init() {
        super.init()

        backgroundImageView
            .add(inRootView: self)
            .fill()
        miniHeader
            .add(inRootView: self)
            .setSize(width: 140, height: 20)
            .setBottomAlignment(marge: 10)
            .setCenterX()
        button
            .add(inRootView: self)
            .setSize(width: 140, height: 20)
            .setCenterX()
            .setBottomAlignment(marge: 10)
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    override
    func layoutSubviews() {
        super.layoutSubviews()

        let alpha = (frame.size.height - minHeight) / (maxHeight - minHeight)
        backgroundImageView.alpha = alpha
        button.alpha = alpha
        miniHeader.alpha = 1 - alpha
    }

    // MARK: Action

    @objc
    func buttonTap() {
        button.isSelected = !button.isSelected
        heightConstraint?.constant = maxHeight
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.superview?.layoutIfNeeded()
        }
    }

}
