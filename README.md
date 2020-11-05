# DStack

* DSTabsViewController
* Extensions for working with constraints


## DSTabsViewController

```swift
class TabsViewController: DSTabsViewController<HeaderView> {

 init() {
  super.init(viewControllers: [
   UIViewController(),
   UIViewController()
  ])
 }

 required
 init?(coder aDecoder: NSCoder) {
  fatalError("init(coder:) has not been implemented")
 }

}
```
### Demo (Click for watching)

[![Watch the Demo](https://github.com/ErusaevAP/DStack/blob/master/Documentations/Images/DSTabsViewController.png)](https://youtu.be/w2z89Qp6E2k)

## Extensions for working with constraints

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
```

### Demo

![ScreenShotPortrait](https://github.com/ErusaevAP/DStack/blob/master/Documentations/Images/ScreenShotPortrait.png)
