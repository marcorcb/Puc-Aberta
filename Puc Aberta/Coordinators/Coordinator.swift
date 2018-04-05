//
//  Coordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 28/02/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

protocol CoordinatorDelegate: class {
    func coordinatorDidExit(_ coordinator: Coordinator)
}

protocol Coordinator: CoordinatorDelegate {
    var coordinatorDelegate: CoordinatorDelegate? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: BaseNavigationController { get set }
    
    func start()
}

extension Coordinator {
    
    func coordinatorDidExit(_ coordinator: Coordinator) {
        guard let index = self.childCoordinators.index(where: { $0 === coordinator }) else { return }
        self.childCoordinators.remove(at: index)
    }
}
