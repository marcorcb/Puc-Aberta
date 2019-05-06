//
//  AppDelegate.swift
//  puc-aberta-ios
//
//  Created by Marco Braga on 28/02/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        Fabric.with([Crashlytics.self])
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.appCoordinator = AppCoordinator(navigationController: BaseNavigationController(), delegate: nil)
        self.appCoordinator?.start()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.appCoordinator?.navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}
