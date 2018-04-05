//
//  MapCoordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class MapCoordinator: Coordinator {
    var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    
    init(navigationController: BaseNavigationController, delegate: CoordinatorDelegate?) {
        self.coordinatorDelegate = delegate
        self.navigationController = navigationController
    }
    
    func start() {
        self.showMap()
        self.navigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_map"), selectedImage: #imageLiteral(resourceName: "icon_map"))
        self.navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.0807383284, green: 0.2549609542, blue: 0.3665698171, alpha: 1)
    }
    
    func showMap() {
        let mapViewController = MapViewController.initFromStoryboard(named: "Home")
        self.navigationController.pushViewController(mapViewController, animated: false)
    }
}

