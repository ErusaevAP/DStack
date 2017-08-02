# DStack

Tools for working with views

![ScreenShotLandscape](https://github.com/ErusaevAP/DStack/blob/master/Documentations/Images/ScreenShotLandscape.png)

```swift
let stackView = UIStackView()
 .addInRootView(view)
 .setTopAnchor(anchor: topLayoutGuide.bottomAnchor, marge: 10)
 .setRightAnchor(anchor: view.rightAnchor, marge: 10)
 .setBottomAnchor(anchor: bottomLayoutGuide.topAnchor, marge: 10)
 .setLeftAnchor(anchor: view.leftAnchor, marge: 10)

let side: CGFloat = 70

label1.addInRootView(stackView)
 .setSize(width: side, height: side)
 .setTopAlignment()
 .setCenterX()

label2.addInRootView(stackView)
 .setSize(width: side, height: side)
 .setRightAlignment()
 .setCenterY()

label3.addInRootView(stackView)
 .setSize(width: side, height: side)
 .setBottomAlignment()
 .setCenterX()

label4.addInRootView(stackView)
 .setSize(width: side, height: side)
 .setLeftAlignment()
 .setCenterY()

label5.addInRootView(stackView)
 .setSize(width: side, height: side)
 .setCenter()
```
