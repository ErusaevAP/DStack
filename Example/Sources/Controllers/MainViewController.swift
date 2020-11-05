//
//  MainViewController.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/2/17.
//

import DStack

final
class MainViewController: UITabBarController {

    init() {
        super.init(nibName: nil, bundle: nil)

        setViewControllers(
            [
                Example1ViewController().navigationController,
                Example2ViewController().navigationController,
                Example3ViewController().navigationController
            ],
            animated: false
        )
    }

    required
    init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private
extension UIViewController {

    var navigationController: UINavigationController {
        let navigationCtrl =  UINavigationController(navigationBarClass: DSNavigationBar.self, toolbarClass: nil)
        navigationCtrl.pushViewController(self, animated: false)
        return navigationCtrl
    }

}
