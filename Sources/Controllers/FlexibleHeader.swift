//
//  FlexibleHeader.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/23/17.
//
//

import UIKit

open
class FlexibleHeader: UIView {

    // MARK: Properties

    open
    var maxHeight: CGFloat {
        return 100
    }

    open
    var minHeight: CGFloat {
        return 0
    }

    var scrollOffset: CGPoint = .zero {
        didSet {
            guard let beginScrollOffset = beginScrollOffset else { return }
            let diffPoint = CGPoint(x: beginScrollOffset.x - scrollOffset.x, y: beginScrollOffset.y - scrollOffset.y)
            let newConstant = beginHeightHeader + diffPoint.y
            if newConstant > maxHeight {
                heightConstraint?.constant = maxHeight
            } else if newConstant < minHeight {
                heightConstraint?.constant = minHeight
            } else {
                heightConstraint?.constant = newConstant
            }
        }
    }

    private
    var heightConstraint: NSLayoutConstraint?

    private
    var beginScrollOffset: CGPoint?

    private
    var beginHeightHeader: CGFloat = 0

    // MARK: Methods

    func willBeginDragging(scrollOffset: CGPoint) {
        beginScrollOffset = scrollOffset
        beginHeightHeader = heightConstraint?.constant ?? 0
    }

    func didEndDragging(velocity: CGPoint) {
        beginScrollOffset = nil
        layoutIfNeeded()
        var newConstant = heightConstraint?.constant ?? 0
        if velocity.y < 0 {
            newConstant = minHeight
        } else if velocity.y > 0 {
            newConstant = maxHeight
        }
        heightConstraint?.constant = newConstant
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.superview?.layoutIfNeeded()
        }
    }

    // MARK: Initialization

    public init() {
        super.init(frame: .zero)

        heightConstraint = heightAnchor.constraint(equalToConstant: maxHeight)
        heightConstraint?.priority = UILayoutPriorityRequired
        heightConstraint?.isActive = true
    }

    public override
    init(frame: CGRect) {
        super.init(frame: .zero)
        fatalError("init(frame:) has not been implemented")
    }

    public required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
