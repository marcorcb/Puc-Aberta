//
//  AuthenticationCoordinator.swift
//  Puc Aberta
//
//  Created by Marco Braga on 28/02/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

protocol AuthenticationCoordinatorDelegate: CoordinatorDelegate {
        func didAuthenticate(on coordinator: AuthenticationCoordinator, with user: User)
}

class AuthenticationCoordinator: Coordinator {
    
    weak var delegate: AuthenticationCoordinatorDelegate?
    weak var coordinatorDelegate: CoordinatorDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: BaseNavigationController
    
    init(navigationController: BaseNavigationController, delegate: AuthenticationCoordinatorDelegate) {
        self.navigationController = navigationController
        self.coordinatorDelegate = delegate
        self.delegate = delegate
    }
    
    func start() {
        self.navigationController.navigationBar.barTintColor = #colorLiteral(red: 0.08235294118, green: 0.2549019608, blue: 0.3647058824, alpha: 1)
        self.navigationController.navigationBar.tintColor = .white
        self.showLogin()
    }
    
    func showLogin() {
        let loginViewController = LoginViewController.initFromStoryboard(named: "Authentication")
        loginViewController.delegate = self
        self.navigationController.setViewControllers([loginViewController], animated: true)
    }
    
    func showRegisterType() {
        let registerTypeViewController = RegisterTypeViewController.initFromStoryboard(named: "Authentication")
        registerTypeViewController.delegate = self
        self.navigationController.pushViewController(registerTypeViewController, animated: true)
    }
    
    func showRegister(url: URL) {
        let registerViewController = RegisterViewController.initFromStoryboard(named: "Authentication")
        registerViewController.registerURL = url
        self.navigationController.pushViewController(registerViewController, animated: true)
    }
}

// MARK: - LoginViewControllerDelegate

extension AuthenticationCoordinator: LoginViewControllerDelegate {
    func didAuthenticate(with user: User) {
        self.delegate?.didAuthenticate(on: self, with: user)
    }
    
    func didTapRegister() {
        self.showRegisterType()
    }
}

// MARK: - RegisterTypeViewControllerDelegate

extension AuthenticationCoordinator: RegisterTypeViewControllerDelegate {
    func didSelectRegister(url: URL) {
        self.showRegister(url: url)
    }
}
