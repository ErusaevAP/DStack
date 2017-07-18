//
//  UIView+DStack.swift
//  MG
//
//  Created by Andrei Erusaev on 6/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit

extension UIView {

    func addSubviews(_ subviews: UIView...) {
        addSubviews(subviews)
    }

    func addSubviews(_ subviews: [UIView?]) {
        subviews.flatMap { $0 }.forEach { addSubview($0) }
    }

    func set(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        return self
    }

    @discardableResult
    func addInRootView(_ rootView: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(self)
        return self
    }

    @discardableResult
    func setHeightAnchor(rootView: UIView) -> Self {
        heightAnchor.constraint(equalTo: rootView.heightAnchor, multiplier: 1).isActive = true
        return self
    }

    @discardableResult
    func setWidthtAnchor(rootView: UIView) -> Self {
        widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 1).isActive = true
        return self
    }

    @discardableResult
    func setSizeAnchor(rootView: UIView) -> Self {
        return self
            .setHeightAnchor(rootView: rootView)
            .setWidthtAnchor(rootView: rootView)
    }

    @discardableResult
    func setTopAnchor(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func setTopAnchor(rootView: UIView, constant: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: rootView.topAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func setBottomAnchor(rootView: UIView, constant: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: rootView.bottomAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func setBottomAnchor(anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func setLeftAnchor(rootView: UIView, constant: CGFloat = 0) -> Self {
        leftAnchor.constraint(equalTo: rootView.leftAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func setLeftAnchor(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        leftAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func setRightAnchor(rootView: UIView, constant: CGFloat = 0) -> Self {
        rightAnchor.constraint(equalTo: rootView.rightAnchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func setRightAnchor(anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        rightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func fill(rootView: UIView) -> Self {
        return self
            .setTopAnchor(rootView: rootView)
            .setBottomAnchor(rootView: rootView)
            .setLeftAnchor(rootView: rootView)
            .setRightAnchor(rootView: rootView)
    }


    @discardableResult
    func setCenterXAnchor(rootView: UIView) -> Self {
        centerXAnchor.constraint(equalTo: rootView.centerXAnchor).isActive = true
        return self
    }

    @discardableResult
    func setCenterYAnchor(rootView: UIView) -> Self {
        centerYAnchor.constraint(equalTo: rootView.centerYAnchor).isActive = true
        return self
    }

    @discardableResult
    func setCenterAnchor(rootView: UIView) -> Self {
        return self
            .setCenterXAnchor(rootView: rootView)
            .setCenterYAnchor(rootView: rootView)
    }

    @discardableResult
    func setCenterAnchorFromSuperview() -> Self {
        guard let superview = superview else { return self }
        return self
            .setCenterXAnchor(rootView: superview)
            .setCenterYAnchor(rootView: superview)
    }

}
