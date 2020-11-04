//
//  UIView+Utils.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/2/17.
//
//

public
extension UIView {

    func add(subviews: UIView...) {
        add(subviews: subviews)
    }

    func add(subviews: [UIView?]) {
        subviews.compactMap { $0 }.forEach { add(subviews: $0) }
    }

    @discardableResult
    func add(inRootView rootView: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        rootView.addSubview(self)
        return self
    }

}

public
extension Array where Element == UIView {

    func stack(
        axis: NSLayoutConstraint.Axis? = nil,
        spacing: CGFloat? = nil,
        alignment: UIStackView.Alignment? = nil,
        distribution: UIStackView.Distribution? = nil
    ) -> UIStackView {
        UIStackView(arrangedSubviews: self)
            .set(axis: axis, spacing: spacing, alignment: alignment, distribution: distribution)
    }

}
