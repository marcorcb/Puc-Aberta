//
//  HomeCoordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 28/02/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

protocol HomeCoordinatorDelegate: CoordinatorDelegate {
    func didLogout(on coordinator: HomeCoordinator)
}

class HomeCoordinator: Coordinator {
    weak var coordinatorDelegate: CoordinatorDelegate?
    weak var delegate: HomeCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    var tabBarController: UITabBarController
    var user: User
    
    init(navigationController: BaseNavigationController, delegate: HomeCoordinatorDelegate?, user: User) {
        self.navigationController = navigationController
        self.coordinatorDelegate = delegate
        self.delegate = delegate
        self.tabBarController = UITabBarController()
        self.user = user
    }
    
    func start() {
        self.createMapCoordinator()
        self.createScheduleCoordinator()
        self.createCoursesCoordinator()
        self.createMenuCoordinator()
        self.tabBarController.viewControllers = self.childCoordinators.map { $0.navigationController }
        self.tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.0807383284, green: 0.2549609542, blue: 0.3665698171, alpha: 1)
        self.tabBarController.tabBar.tintColor = .white
        self.navigationController.setNavigationBarHidden(true, animated: false)
        self.navigationController.setViewControllers([self.tabBarController], animated: true)
    }
    
    func createMapCoordinator() {
        let navigationController = BaseNavigationController()
        let coordinator = MapCoordinator(navigationController: navigationController, delegate: self)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func createScheduleCoordinator() {
        let navigationController = BaseNavigationController()
        let coordinator = ScheduleCoordinator(navigationController: navigationController, delegate: self, user: self.user)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func createCoursesCoordinator() {
        let navigationController = BaseNavigationController()
        let coordinator = CoursesCoordinator(navigationController: navigationController, delegate: self)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
    
    func createMenuCoordinator() {
        let navigationController = BaseNavigationController()
        let coordinator = MenuCoordinator(navigationController: navigationController, delegate: self)
        coordinator.start()
        self.childCoordinators.append(coordinator)
    }
}

// MARK: - MenuCoordinatorDelegate

extension HomeCoordinator: MenuCoordinatorDelegate {
    func didConfirmLogout() {
        self.navigationController.setNavigationBarHidden(false, animated: false)
        self.delegate?.didLogout(on: self)
    }
}
