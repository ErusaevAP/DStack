//
//  UIView+DStack.swift
//  MG
//
//  Created by Andrei Erusaev on 6/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit

// MARK: - Size

public
extension UIView {

    @discardableResult
    func setHeight(fromView: UIView? = nil) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1).isActive = true
        return self
    }

    @discardableResult
    func setWidtht(fromView: UIView? = nil) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        return self
    }

    @discardableResult
    func setSize(fromView: UIView) -> Self {
        let fromView = fromView ?? superview
        return self
            .setHeight(fromView: fromView)
            .setWidtht(fromView: fromView)
    }

    @discardableResult
    func setSize(size: CGSize) -> Self {
        return setSize(width: size.width, height: size.height)
    }

    @discardableResult
    func setSize(width: CGFloat? = nil, height: CGFloat? = nil) -> Self {
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        return self
    }

}

// MARK: - Anchor

public
extension UIView {

    @discardableResult
    func setTopAnchor(anchor: NSLayoutYAxisAnchor, marge: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: marge).isActive = true
        return self
    }

    @discardableResult
    func setBottomAnchor(anchor: NSLayoutYAxisAnchor, marge: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: -marge).isActive = true
        return self
    }

    @discardableResult
    func setLeftAnchor(anchor: NSLayoutXAxisAnchor, marge: CGFloat = 0) -> Self {
        leftAnchor.constraint(equalTo: anchor, constant: marge).isActive = true
        return self
    }

    @discardableResult
    func setRightAnchor(anchor: NSLayoutXAxisAnchor, marge: CGFloat = 0) -> Self {
        rightAnchor.constraint(equalTo: anchor, constant: -marge).isActive = true
        return self
    }

}

// MARK: - Fill

public
extension UIView {

    @discardableResult
    func fill(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        return self
            .setTopAlignment(fromView: fromView, marge: marge)
            .setBottomAlignment(fromView: fromView, marge: marge)
            .setLeftAlignment(fromView: fromView, marge: marge)
            .setRightAlignment(fromView: fromView, marge: marge)
    }

}

// MARK: - Alignment

public
extension UIView {

    @discardableResult
    func setTopAlignment(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        return setTopAnchor(anchor: view.topAnchor, marge: marge)
    }

    @discardableResult
    func setBottomAlignment(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        return setBottomAnchor(anchor: view.bottomAnchor, marge: marge)
    }

    @discardableResult
    func setLeftAlignment(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        return setLeftAnchor(anchor: view.leftAnchor, marge: marge)
    }

    @discardableResult
    func setRightAlignment(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        return setRightAnchor(anchor: view.rightAnchor, marge: marge)
    }

}

// MARK: - Center

public
extension UIView {

    @discardableResult
    func setCenterX(fromView: UIView? = nil) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return self
    }

    @discardableResult
    func setCenterY(fromView: UIView? = nil) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return self
    }

    @discardableResult
    func setCenter(fromView: UIView? = nil) -> Self {
        let fromView = fromView ?? superview
        return self
            .setCenterX(fromView: fromView)
            .setCenterY(fromView: fromView)
    }

}
