//
//  AppDelegate.swift
//  DStackExample
//
//  Created by Andrei Erusaev on 8/2/17.
//  Copyright © 2017 erusaevap. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    ) -> Bool {

        configureAppearances()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = RootViewController()
        window?.makeKeyAndVisible()

        return true
    }

    private
    func configureAppearances() {
        UITabBar.appearance().tintColor = .red
        UINavigationBar.appearance().tintColor = .red
    }

}
