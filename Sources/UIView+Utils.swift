//
//  UIView+Utils.swift
//  Pods
//
//  Created by Andrei Erusaev on 8/2/17.
//
//

import UIKit

public
extension UIView {

    func addSubviews(_ subviews: UIView...) {
        addSubviews(subviews)
    }

    func addSubviews(_ subviews: [UIView?]) {
        subviews.flatMap { $0 }.forEach { addSubview($0) }
    }

}
