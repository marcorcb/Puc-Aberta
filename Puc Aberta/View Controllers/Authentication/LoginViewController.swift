//
//  LoginViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 28/02/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol LoginViewControllerDelegate: class {
    func didAuthenticate(with user: User)
    func didTapRegister()
}

class LoginViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var cpfTextField: PATextField!
    @IBOutlet weak var birthdatePickerField: PADatePickerField!

    // MARK: - Members

    private let loginPresenter = LoginPresenter()
    weak var delegate: LoginViewControllerDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: - Private

    func setup() {
        self.loginPresenter.attachView(self)
        self.birthdatePickerField.setDates(maximumDate: Date(), minimumDate: nil)
    }

    // MARK: - IBActions

    @IBAction func login(_ sender: Any) {
        self.loginPresenter.validate(cpf: self.cpfTextField.unmaskedText!, datePickerField: self.birthdatePickerField)
    }

    @IBAction func register(_ sender: Any) {
        self.delegate?.didTapRegister()
    }
}

// MARK: - LoginProtocol

extension LoginViewController: LoginProtocol {
    func startLoading() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    func stopLoading() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }

    func showAlert(message: String) {
        self.present(PAAlertController(titleImage: #imageLiteral(resourceName: "icon_error"), message: message), animated: false, completion: nil)
    }

    func didAuthenticate(with user: User) {
        self.delegate?.didAuthenticate(with: user)
    }
}
