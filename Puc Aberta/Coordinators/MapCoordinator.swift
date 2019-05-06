//
//  MapCoordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class MapCoordinator: Coordinator {
    weak var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    var user: User

    init(navigationController: BaseNavigationController, delegate: CoordinatorDelegate?, user: User) {
        self.coordinatorDelegate = delegate
        self.navigationController = navigationController
        self.user = user
    }

    func start() {
        self.showMap()
        self.navigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_map"), selectedImage: #imageLiteral(resourceName: "icon_map"))
        self.navigationController.navigationBar.barTintColor = Colors.appDefault
    }

    func showMap() {
        let mapViewController = MapViewController.initFromStoryboard(named: "Home")
        mapViewController.delegate = self
        mapViewController.user = self.user
        self.navigationController.pushViewController(mapViewController, animated: false)
    }

    func showPhoto() {
        let photoViewController = PhotoViewController.initFromStoryboard(named: "Home")
        self.navigationController.pushViewController(photoViewController, animated: true)
    }
}

// MARK: - MapViewControllerDelegate

extension MapCoordinator: MapViewControllerDelegate {
    func didTapCamera() {
        self.showPhoto()
    }
}
