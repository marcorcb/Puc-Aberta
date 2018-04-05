//
//  ScheduleCoordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class ScheduleCoordinator: Coordinator {
    var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    var user: User
    
    init(navigationController: BaseNavigationController, delegate: CoordinatorDelegate?, user: User) {
        self.coordinatorDelegate = delegate
        self.navigationController = navigationController
        self.user = user
    }
    
    func start() {
        self.showSchedule()
        self.navigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_schedule"), selectedImage: #imageLiteral(resourceName: "icon_schedule"))
        self.navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.0807383284, green: 0.2549609542, blue: 0.3665698171, alpha: 1)
    }
    
    func showSchedule() {
        let scheduleViewController = ScheduleViewController.initFromStoryboard(named: "Home")
        scheduleViewController.user = self.user
        scheduleViewController.delegate = self
        self.navigationController.pushViewController(scheduleViewController, animated: false)
    }
    
    func showScheduleDetails(for event: Event, unit: Unit, isSubscribed: Bool) {
        let scheduleDetailsViewController = ScheduleDetailsViewController.initFromStoryboard(named: "Schedule")
        scheduleDetailsViewController.event = event
        scheduleDetailsViewController.unit = unit
        scheduleDetailsViewController.isSubscribed = isSubscribed
        self.navigationController.pushViewController(scheduleDetailsViewController, animated: true)
    }
}

// MARK: - ScheduleViewControllerDelegate

extension ScheduleCoordinator: ScheduleViewControllerDelegate {
    func didSelect(event: Event, unit: Unit, isSubscribed: Bool) {
        self.showScheduleDetails(for: event, unit: unit, isSubscribed: isSubscribed)
    }
}
