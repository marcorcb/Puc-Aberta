//
//  CoursesCoordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class CoursesCoordinator: Coordinator {
    weak var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController

    init(navigationController: BaseNavigationController, delegate: CoordinatorDelegate?) {
        self.coordinatorDelegate = delegate
        self.navigationController = navigationController
    }

    func start() {
        self.showCourses()
        self.navigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_courses"), selectedImage: #imageLiteral(resourceName: "icon_courses"))
        self.navigationController.navigationBar.barTintColor = Colors.appDefault
    }

    func showCourses() {
        let coursesViewController = CoursesViewController.initFromStoryboard(named: "Home")
        self.navigationController.pushViewController(coursesViewController, animated: false)
    }
}
