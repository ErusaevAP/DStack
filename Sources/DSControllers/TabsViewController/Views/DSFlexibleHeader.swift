//
//  DSFlexibleHeader.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/23/17.
//
//

open
class DSFlexibleHeader: UIView {

    open
    var maxHeight: CGFloat {
        100
    }

    open
    var minHeight: CGFloat {
        0
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

    open
    var heightConstraint: NSLayoutConstraint?

    private
    var beginScrollOffset: CGPoint?

    private
    var beginHeightHeader: CGFloat = 0

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

    public
    init() {
        super.init(frame: .zero)
        setup()
    }

    public override
    init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required
    init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private
    func setup() {
        heightConstraint = heightAnchor.constraint(equalToConstant: maxHeight)
        heightConstraint?.priority = .required
        heightConstraint?.isActive = true
    }
}
