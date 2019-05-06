//
//  AppCoordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 28/02/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import KeychainSwift

class AppCoordinator: Coordinator {

    weak var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController

    init(navigationController: BaseNavigationController, delegate: CoordinatorDelegate?) {
        self.navigationController = navigationController
        self.coordinatorDelegate = delegate
    }

    func start() {
        let keychain = KeychainSwift()
        if let cpf = keychain.get(Constants.userCpfKey), let birthdate = keychain.get(Constants.userBirthdateKey) {
            self.showSplash(cpf: cpf, birthdate: birthdate)
        } else {
            self.showAuthentication()
        }
    }

    func showSplash(cpf: String, birthdate: String) {
        let splashViewController = SplashViewController.initFromStoryboard(named: "Authentication")
        splashViewController.delegate = self
        splashViewController.cpf = cpf
        splashViewController.birthdate = birthdate
        self.navigationController.pushViewController(splashViewController, animated: true)
    }

    func showAuthentication() {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: self.navigationController,
                                                                  delegate: self)
        authenticationCoordinator.start()
        self.childCoordinators.append(authenticationCoordinator)
    }

    func showHome(for user: User) {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController, delegate: self,
                                              user: user)
        homeCoordinator.start()
        self.childCoordinators.append(homeCoordinator)
    }
}

// MARK: - AuthenticationCoordinatorDelegate

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func didAuthenticate(on coordinator: AuthenticationCoordinator, with user: User) {
        self.coordinatorDidExit(coordinator)
        self.showHome(for: user)
    }
}

// MARK: - SplashViewControllerDelegate

extension AppCoordinator: SplashViewControllerDelegate {
    func didAuthenticate(with user: User) {
        self.showHome(for: user)
    }

    func didFailToAuthenticate() {
        self.showAuthentication()
    }
}

// MARK: - HomeCoordinatorDelegate

extension AppCoordinator: HomeCoordinatorDelegate {
    func didLogout(on coordinator: HomeCoordinator) {
        self.coordinatorDelegate?.coordinatorDidExit(coordinator)
        let keychain = KeychainSwift()
        keychain.clear()
        self.showAuthentication()
    }
}

//extension AppCoordinator: TabBarCoordinatorDelegate {
//    func didLogout(on coordinator: TabBarCoordinator) {
//        self.coordinatorDelegate?.coordinatorDidExit(coordinator)
//        UserDefaults.standard.set(nil, forKey: "authenticationHeaders")
//        UserDefaults.standard.set(nil, forKey: "userDictionaryDefaultsKey")
//        UserDefaults.standard.set(false, forKey: "RegisterShow")
//        APICacheManager.shared.clearCache()
//        self.showAuthentication()
//    }
//}
