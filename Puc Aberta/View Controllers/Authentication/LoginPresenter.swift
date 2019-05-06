//
//  LoginPresenter.swift
//  Puc Aberta
//
//  Created by Marco Braga on 01/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import KeychainSwift

protocol LoginProtocol: AnyObject {
    func startLoading()
    func stopLoading()
    func showAlert(message: String)
    func didAuthenticate(with user: User)
}

class LoginPresenter {

    weak private var loginView: LoginProtocol?

    func attachView(_ view: LoginProtocol) {
        self.loginView = view
    }

    func validate(cpf: String, datePickerField: PADatePickerField) {
        if cpf.count != 11 {
            self.loginView?.showAlert(message: NSLocalizedString("CPF obrigatório", comment: ""))
        } else if !cpf.isValidCpf() {
            self.loginView?.showAlert(message: NSLocalizedString("CPF inválido", comment: ""))
        } else if !datePickerField.hasText {
            self.loginView?.showAlert(message: NSLocalizedString("Data de nascimento obrigatória", comment: ""))
        } else {
            self.login(cpf: cpf, birthdate: datePickerField.pickerView.date)
        }
    }

    func saveLoginFields(cpf: String, birthdate: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let keychain = KeychainSwift()
        keychain.set(cpf, forKey: Constants.userCpfKey)
        keychain.set(dateFormatter.string(from: birthdate), forKey: Constants.userBirthdateKey)
    }

    func login(cpf: String, birthdate: Date) {
        self.loginView?.startLoading()
        LoginService.login(cpf: cpf, birthdate: birthdate) { (user, error, _) in
            self.loginView?.stopLoading()
            if let user = user, error == nil {
                self.saveLoginFields(cpf: cpf, birthdate: birthdate)
                self.loginView?.didAuthenticate(with: user)
            } else {
                self.loginView?.showAlert(message: "Usuário não encontrado")
            }
        }
    }
}
