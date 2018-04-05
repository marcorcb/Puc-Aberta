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
        self.navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.0807383284, green: 0.2549609542, blue: 0.3665698171, alpha: 1)
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
}

// MARK: - MenuTableViewControllerDelegate

extension MenuCoordinator: MenuTableViewControllerDelegate {
    func didSelectTwitter() {
        self.showTwitter()
    }
    
    func didConfirmLogout() {
        self.delegate?.didConfirmLogout()
    }
}
