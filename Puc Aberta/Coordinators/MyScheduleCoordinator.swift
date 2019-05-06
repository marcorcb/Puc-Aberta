//
//  MyScheduleCoordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 22/04/2018.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

protocol MyScheduleCoordinatorDelegate: CoordinatorDelegate {
    func openOnMap(lecture: String)
}

class MyScheduleCoordinator: Coordinator {
    weak var coordinatorDelegate: CoordinatorDelegate?
    weak var delegate: MyScheduleCoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    var user: User

    init(navigationController: BaseNavigationController, delegate: MyScheduleCoordinatorDelegate?, user: User) {
        self.delegate = delegate
        self.coordinatorDelegate = delegate
        self.navigationController = navigationController
        self.user = user
    }

    func start() {
        self.showMySchedule()
        self.navigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_myschedule"), selectedImage: #imageLiteral(resourceName: "icon_myschedule"))
        self.navigationController.navigationBar.barTintColor = Colors.appDefault
    }

    func showMySchedule() {
        let myScheduleViewController = MyScheduleViewController.initFromStoryboard(named: "Home")
        myScheduleViewController.delegate = self
        myScheduleViewController.user = self.user
        self.navigationController.pushViewController(myScheduleViewController, animated: false)
    }
}

// MARK: - MyScheduleViewControllerDelegate

extension MyScheduleCoordinator: MyScheduleViewControllerDelegate {
    func didTapCellOpenOnMap(lecture: String) {
        self.delegate?.openOnMap(lecture: lecture)
    }
}
