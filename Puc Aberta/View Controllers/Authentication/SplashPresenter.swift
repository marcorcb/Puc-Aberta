//
//  SplashPresenter.swift
//  Puc Aberta
//
//  Created by Marco Braga on 19/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

protocol SplashProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func didAuthenticate(with user: User)
    func didFailToAuthenticate()
}

class SplashPresenter {
    
    weak private var splashView: SplashProtocol?
    
    func attachView(_ view: SplashProtocol) {
        self.splashView = view
    }
    
    func checkUser(cpf: String, birthdate: String) {
        self.splashView?.startLoading()
        LoginService.login(cpf: cpf, birthdate: birthdate) { (user, error, cache) in
            self.splashView?.stopLoading()
            if let user = user, error == nil {
                self.splashView?.didAuthenticate(with: user)
            } else {
                self.splashView?.didFailToAuthenticate()
            }
        }
    }
}
