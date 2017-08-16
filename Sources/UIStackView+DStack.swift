//
//  UIStackView+Layout.swift
//  MG
//
//  Created by Andrei Erusaev on 6/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit

public
extension UIStackView {

    @discardableResult override
    func add(inRootView rootView: UIView) -> Self {
        super.add(inRootView: rootView)
        return self
    }

    @discardableResult
    func add(arrangedSubviews subviews: UIView...) -> Self {
        add(arrangedSubviews: subviews)
        return self
    }

    @discardableResult
    func add(arrangedSubviews subviews: [UIView?]) -> Self {
        subviews.flatMap { $0 }.forEach { addArrangedSubview($0) }
        return self
    }

    @discardableResult
    func set(
        axis: UILayoutConstraintAxis? = nil,
        spacing: CGFloat? = nil,
        alignment: UIStackViewAlignment? = nil,
        distribution: UIStackViewDistribution? = nil
    ) -> Self {
        if let axis = axis { self.axis = axis }
        if let spacing = spacing { self.spacing = spacing }
        if let alignment = alignment { self.alignment = alignment }
        if let distribution = distribution { self.distribution = distribution }
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }

}
