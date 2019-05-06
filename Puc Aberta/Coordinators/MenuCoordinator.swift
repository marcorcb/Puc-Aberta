//
//  MenuCoordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

protocol MenuCoordinatorDelegate: CoordinatorDelegate {
    func didConfirmLogout()
}

class MenuCoordinator: Coordinator {
    weak var coordinatorDelegate: CoordinatorDelegate?
    weak var delegate: MenuCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController

    init(navigationController: BaseNavigationController, delegate: MenuCoordinatorDelegate?) {
        self.coordinatorDelegate = delegate
        self.delegate = delegate
        self.navigationController = navigationController
    }

    func start() {
        self.showMenu()
        self.navigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_menu"), selectedImage: #imageLiteral(resourceName: "icon_menu"))
        self.navigationController.navigationBar.barTintColor = Colors.appDefault
    }

    func showMenu() {
        let menuTableViewController = MenuTableViewController.initFromStoryboard(named: "Home")
        menuTableViewController.delegate = self
        self.navigationController.pushViewController(menuTableViewController, animated: false)
    }

    func showTwitter() {
        let twitterViewController = TwitterViewController.initFromStoryboard(named: "Menu")
        self.navigationController.pushViewController(twitterViewController, animated: true)
    }

    func showAbout() {
        let aboutViewController = AboutViewController.initFromStoryboard(named: "Menu")
        self.navigationController.pushViewController(aboutViewController, animated: true)
    }
}

// MARK: - MenuTableViewControllerDelegate

extension MenuCoordinator: MenuTableViewControllerDelegate {
    func didSelectTwitter() {
        self.showTwitter()
    }

    func didSelectAbout() {
        self.showAbout()
    }

    func didConfirmLogout() {
        self.delegate?.didConfirmLogout()
    }
}
