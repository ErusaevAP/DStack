//
//  WelcomelView.swift
//  DStackExample
//
//  Created by Andrey Erusaev on 13/09/2018.
//  Copyright © 2018 erusaevap. All rights reserved.
//

import UIKit

class WelcomelView: UIView {

    init() {
        super.init(frame: .zero)

        let label = UILabel()
        label.text = "Welcome"
        label.add(inRootView: self).setCenter()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}