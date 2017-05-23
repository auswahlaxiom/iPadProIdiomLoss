//
//  AppDelegate.swift
//  iPadProTraitCollectionIdiomLoss
//
//  Created by Ada Turner on 5/23/17.
//  Copyright © 2017 Auswahlaxiom. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - UIApplicationDelegate

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupRootViewController()

        return true
    }

    // MARK: - Internal

    var rootViewController: UINavigationController?

    // MARK: - Private

    private func setupRootViewController() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)

        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.rootViewController = navigationController
        self.window = window
    }
}

