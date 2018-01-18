//
//  DSNavigationBar.swift
//  DStackExample
//
//  Created by Andrey Erusaev on 18/01/2018.
//  Copyright © 2018 erusaevap. All rights reserved.
//

import UIKit

// MARK: -

public
class DSNavigationBarSatate {

    // MARK: Properties

    public
    static
    var clear: DSNavigationBarSatate {
        return DSNavigationBarSatate(
            backgroundImage: UIImage(),
            shadowImage: UIImage(),
            isTranslucent: true,
            backgroundColor: .clear
        )
    }

    let backgroundImage: UIImage?

    let shadowImage: UIImage?

    let isTranslucent: Bool

    let backgroundColor: UIColor?

    let barStyle: UIBarStyle

    // MARK: Initialization

    public
    init(
        backgroundImage: UIImage? = nil,
        shadowImage: UIImage? = nil,
        isTranslucent: Bool = false,
        backgroundColor: UIColor? = nil,
        barStyle: UIBarStyle = .default) {
        self.backgroundImage = backgroundImage
        self.shadowImage = shadowImage
        self.isTranslucent = isTranslucent
        self.backgroundColor = backgroundColor
        self.barStyle = barStyle
    }

}

// MARK: -

public
class DSNavigationBar: UINavigationBar {

    // MARK: Properties

    private
    var barStates: [DSNavigationBarSatate] = []

    // MARK: Initialization

    override
    init(frame: CGRect) {
        super.init(frame: frame)
        pushCurrentState()
    }

    public
    required
    init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        pushCurrentState()
    }

    // MARK: Public Methods

    public
    func pushState(barState: DSNavigationBarSatate) {
        barStates.append(barState)
        applayBarState(barState: barState)
    }

    public
    func popState() {
        if barStates.count <= 1 { return }
        barStates.removeLast()
        if let lastBarState = barStates.last {
            applayBarState(barState: lastBarState)
        }
    }

    // MARK: Private Methods

    private
    func pushCurrentState() {
        let barState = DSNavigationBarSatate(
            backgroundImage: backIndicatorImage,
            shadowImage: shadowImage,
            isTranslucent: isTranslucent,
            backgroundColor: backgroundColor
        )
        pushState(barState: barState)
    }

    private
    func applayBarState(barState: DSNavigationBarSatate) {
        setBackgroundImage(barState.backgroundImage, for: .default)
        shadowImage = barState.shadowImage
        isTranslucent = barState.isTranslucent
        backgroundColor = barState.backgroundColor
        barStyle = barState.barStyle
    }

}

// MARK: -

public
extension UINavigationController {

    var dsNavigationBar: DSNavigationBar? {
        return navigationBar as? DSNavigationBar
    }

}
