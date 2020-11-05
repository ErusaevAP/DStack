//
//  DSNavigationBar.swift
//  DStackExample
//
//  Created by Andrey Erusaev on 18/01/2018.
//

public
class DSNavigationBarSatate {

    public
    static
    var clear: DSNavigationBarSatate {
        DSNavigationBarSatate(
            backgroundImage: UIImage(),
            shadowImage: UIImage(),
            isTranslucent: true,
            backgroundColor: .clear,
            tintColor: .black,
            barStyle: .black
        )
    }

    let backgroundImage: UIImage?

    let shadowImage: UIImage?

    let isTranslucent: Bool

    let backgroundColor: UIColor?

    let barStyle: UIBarStyle

    let tintColor: UIColor?

    public
    init(
        backgroundImage: UIImage? = nil,
        shadowImage: UIImage? = nil,
        isTranslucent: Bool = false,
        backgroundColor: UIColor? = nil,
        tintColor: UIColor? = nil,
        barStyle: UIBarStyle = .default
    ) {
        self.backgroundImage = backgroundImage
        self.shadowImage = shadowImage
        self.isTranslucent = isTranslucent
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.barStyle = barStyle
    }

}

public
class DSNavigationBar: UINavigationBar {

    private
    var barStates: [DSNavigationBarSatate] = []

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

    public
    func pushState(barState: DSNavigationBarSatate) {
        barStates.append(barState)
        applayBarState(barState: barState)
    }

    public
    func popState() {
        guard barStates.count > 1 else {
            return
        }
        barStates.removeLast()
        guard let lastBarState = barStates.last else {
            return
        }
        applayBarState(barState: lastBarState)
    }

    private
    func pushCurrentState() {
        let barState = DSNavigationBarSatate(
            backgroundImage: backIndicatorImage,
            shadowImage: shadowImage,
            isTranslucent: isTranslucent,
            backgroundColor: backgroundColor,
            tintColor: tintColor
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
        tintColor = barState.tintColor
    }

}

public
extension UINavigationController {

    var dsNavigationBar: DSNavigationBar? {
        navigationBar as? DSNavigationBar
    }

}
