//
//  MenuTableViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

protocol MenuTableViewControllerDelegate: class {
    func didSelectTwitter()
    func didConfirmLogout()
}

class MenuTableViewController: BaseTableViewController {
    
    // MARK: - Members
    
    weak var delegate: MenuTableViewControllerDelegate?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - Private
    
    func setupUI() {
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.delegate?.didSelectTwitter()
            break
        case 1:
            let cancelAction = PAAlertAction(title: "NÃO")
            let confirmAction = PAAlertAction(title: "SIM") {
                self.delegate?.didConfirmLogout()
            }
            self.present(PAAlertController(titleImage: #imageLiteral(resourceName: "icon_question"), message: "Tem certeza de que deseja fazer logout?", actions: [cancelAction, confirmAction]), animated: false, completion: nil)
            break
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
