//
//  SplashViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 19/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol SplashViewControllerDelegate: class {
    func didAuthenticate(with user: User)
    func didFailToAuthenticate()
}

class SplashViewController: BaseViewController {
    
    // MARK: - Members
    
    private let splashPresenter = SplashPresenter()
    weak var delegate: SplashViewControllerDelegate?
    var cpf: String?
    var birthdate: String?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Private
    
    func setup() {
        guard let cpf = self.cpf else { return }
        guard let birthdate = self.birthdate else { return }
        self.splashPresenter.attachView(self)
        self.splashPresenter.checkUser(cpf: cpf, birthdate: birthdate)
    }
}

// MARK: - SplashProtocol

extension SplashViewController: SplashProtocol {
    func startLoading() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func stopLoading() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func didAuthenticate(with user: User) {
        self.delegate?.didAuthenticate(with: user)
    }
    
    func didFailToAuthenticate() {
        self.didFailToAuthenticate()
    }
}
