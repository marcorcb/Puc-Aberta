//
//  RegisterTypeViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

protocol RegisterTypeViewControllerDelegate: class {
    func didSelectRegister(url: URL)
}

class RegisterTypeViewController: BaseViewController {

    // MARK: - Members

    weak var delegate: RegisterTypeViewControllerDelegate?

    // MARK: - IBActions

    @IBAction func soloRegister(_ sender: Any) {
        guard let url = URL(string: "http://portal.pucminas.br/pucaberta/inscrito_cadastro.php") else { return }
        self.delegate?.didSelectRegister(url: url)
    }

    @IBAction func schoolRegister(_ sender: Any) {
        guard let url = URL(string: "http://portal.pucminas.br/pucaberta/escola/escola_cadastro.php") else { return }
        self.delegate?.didSelectRegister(url: url)
    }
}
