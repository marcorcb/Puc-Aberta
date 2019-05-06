//
//  AboutViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 23/04/2018.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    // MARK: - Outlets

    @IBOutlet weak var versionLabel: UILabel!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    // MARK: - Private

    func setupUI() {
        guard let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else { return }
        self.versionLabel.text = String.localizedStringWithFormat(NSLocalizedString("Versão %@", comment: ""),
                                                                  appVersion)
    }

}
