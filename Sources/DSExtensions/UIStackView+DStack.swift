//
//  UIStackView+Layout.swift
//  MG
//
//  Created by Andrei Erusaev on 6/21/17.
//

public
extension UIStackView {

    @discardableResult
    func add(arrangedSubviews subviews: UIView...) -> Self {
        add(arrangedSubviews: subviews)
        return self
    }

    @discardableResult
    func add(arrangedSubviews subviews: [UIView?]) -> Self {
        subviews.compactMap { $0 }.forEach { addArrangedSubview($0) }
        return self
    }

    @discardableResult
    func set(
        axis: NSLayoutConstraint.Axis? = nil,
        spacing: CGFloat? = nil,
        alignment: UIStackView.Alignment? = nil,
        distribution: UIStackView.Distribution? = nil
    ) -> Self {
        if let axis = axis { self.axis = axis }
        if let spacing = spacing { self.spacing = spacing }
        if let alignment = alignment { self.alignment = alignment }
        if let distribution = distribution { self.distribution = distribution }
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }

}
