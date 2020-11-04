//
//  UIView+DStack.swift
//  MG
//
//  Created by Andrei Erusaev on 6/21/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

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
    func setWidth(fromView: UIView? = nil) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        return self
    }

    @discardableResult
    func setSize(fromView: UIView? = nil) -> Self {
        let fromView = fromView ?? superview
        return self
            .setHeight(fromView: fromView)
            .setWidth(fromView: fromView)
    }

    @discardableResult
    func setSize(size: CGSize) -> Self {
        setSize(width: size.width, height: size.height)
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

// MARK: - Anchor EqualTo

public
extension UIView {

    @discardableResult
    func setLeftAnchor(equalTo anchor: NSLayoutXAxisAnchor, marge: CGFloat = 0) -> Self {
        leftAnchor.constraint(equalTo: anchor, constant: marge).isActive = true
        return self
    }

    @discardableResult
    func setRightAnchor(equalTo anchor: NSLayoutXAxisAnchor, marge: CGFloat = 0) -> Self {
        rightAnchor.constraint(equalTo: anchor, constant: -marge).isActive = true
        return self
    }

    @discardableResult
    func setTopAnchor(equalTo anchor: NSLayoutYAxisAnchor, marge: CGFloat = 0) -> Self {
        topAnchor.constraint(equalTo: anchor, constant: marge).isActive = true
        return self
    }

    @discardableResult
    func setBottomAnchor(equalTo anchor: NSLayoutYAxisAnchor, marge: CGFloat = 0) -> Self {
        bottomAnchor.constraint(equalTo: anchor, constant: -marge).isActive = true
        return self
    }

    @discardableResult
    func setHeightAnchor(equalTo anchor: NSLayoutDimension, marge: CGFloat = 0) -> Self {
        heightAnchor.constraint(equalTo: anchor, multiplier: 1).isActive = true
        return self
    }

    @discardableResult
    func setWidthAnchor(equalTo anchor: NSLayoutDimension, marge: CGFloat = 0) -> Self {
        widthAnchor.constraint(equalTo: anchor, multiplier: 1).isActive = true
        return self
    }

    @discardableResult
    func setLeadingAnchor(
        equalTo anchor: NSLayoutXAxisAnchor,
        marge: CGFloat = 0,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        let constraint = leadingAnchor.constraint(equalTo: anchor)
        constraint.isActive = true
        constraint.priority = priority
        return self
    }

    @discardableResult
    func setTrailingAnchor(
        equalTo anchor: NSLayoutXAxisAnchor,
        marge: CGFloat = 0,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        let constraint = trailingAnchor.constraint(equalTo: anchor)
        constraint.isActive = true
        constraint.priority = priority
        return self
    }

}

// MARK: - Anchor GreaterThanOrEqualTo

public
extension UIView {

    @discardableResult
    func setLeftAnchor(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, marge: CGFloat = 0) -> Self {
        leftAnchor.constraint(greaterThanOrEqualTo: anchor, constant: marge).isActive = true
        return self
    }

    @discardableResult
    func setRightAnchor(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, marge: CGFloat = 0) -> Self {
        rightAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -marge).isActive = true
        return self
    }

    @discardableResult
    func setTopAnchor(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, marge: CGFloat = 0) -> Self {
        topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: marge).isActive = true
        return self
    }

    @discardableResult
    func setBottomAnchor(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, marge: CGFloat = 0) -> Self {
        bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -marge).isActive = true
        return self
    }

    @discardableResult
    func setHeightAnchor(greaterThanOrEqualTo anchor: NSLayoutDimension, marge: CGFloat = 0) -> Self {
        heightAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: 1).isActive = true
        return self
    }

    @discardableResult
    func setWidthAnchor(greaterThanOrEqualTo anchor: NSLayoutDimension, marge: CGFloat = 0) -> Self {
        widthAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: 1).isActive = true
        return self
    }

    @discardableResult
    func setLeadingAnchor(
        greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor,
        marge: CGFloat = 0,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        let constraint = leadingAnchor.constraint(greaterThanOrEqualTo: anchor)
        constraint.isActive = true
        constraint.priority = priority
        return self
    }

    @discardableResult
    func setTrailingAnchor(
        greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor,
        marge: CGFloat = 0,
        priority: UILayoutPriority = .defaultHigh
    ) -> Self {
        let constraint = trailingAnchor.constraint(greaterThanOrEqualTo: anchor)
        constraint.isActive = true
        constraint.priority = priority
        return self
    }

}

// MARK: - Fill

public
extension UIView {

    @discardableResult
    func fill(viewController: UIViewController, marge: CGFloat = 0) -> Self {
        setTopAnchor(equalTo: viewController.topLayoutGuide.bottomAnchor, marge: marge)
            .setRightAnchor(equalTo: viewController.view.rightAnchor, marge: marge)
            .setBottomAnchor(equalTo: viewController.bottomLayoutGuide.topAnchor, marge: marge)
            .setLeftAnchor(equalTo: viewController.view.leftAnchor, marge: marge)
    }

    @discardableResult
    func fill(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        return self
            .setTopAlignment(fromView: fromView, marge: marge)
            .setBottomAlignment(fromView: fromView, marge: marge)
            .setLeftAlignment(fromView: fromView, marge: marge)
            .setRightAlignment(fromView: fromView, marge: marge)
    }

    @discardableResult
    func fill(fromView: UIView? = nil, inset: UIEdgeInsets) -> Self {
        let fromView = fromView ?? superview
        return self
            .setTopAlignment(fromView: fromView, marge: inset.top)
            .setBottomAlignment(fromView: fromView, marge: inset.bottom)
            .setLeftAlignment(fromView: fromView, marge: inset.left)
            .setRightAlignment(fromView: fromView, marge: inset.right)
    }

}

// MARK: - Alignment

public
extension UIView {

    @discardableResult
    func setTopAlignment(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        return setTopAnchor(equalTo: view.topAnchor, marge: marge)
    }

    @discardableResult
    func setBottomAlignment(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        return setBottomAnchor(equalTo: view.bottomAnchor, marge: marge)
    }

    @discardableResult
    func setLeftAlignment(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        return setLeftAnchor(equalTo: view.leftAnchor, marge: marge)
    }

    @discardableResult
    func setRightAlignment(fromView: UIView? = nil, marge: CGFloat = 0) -> Self {
        let fromView = fromView ?? superview
        guard let view = fromView else { return self }

        return setRightAnchor(equalTo: view.rightAnchor, marge: marge)
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
