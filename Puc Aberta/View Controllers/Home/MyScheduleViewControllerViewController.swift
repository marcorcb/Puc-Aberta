//
//  MyScheduleViewControllerViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 23/04/2018.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import MessageUI

protocol MyScheduleViewControllerDelegate: class {
    func didTapCellOpenOnMap(lecture: String)
}

class MyScheduleViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noScheduleView: UIView!
    
    // MARK: - Members
    
    weak var delegate: MyScheduleViewControllerDelegate?
    var user: User?
    fileprivate var dataSource = [Lecture]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Private
    
    func setup() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        guard let user = self.user else { return }
        guard let lectures = user.lectures else { return }
        self.noScheduleView.isHidden = true
        self.dataSource = lectures
    }
    
    func configuredMailComposeViewController(lecture: String) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["pucaberta@pucminas.br"])
        mailComposerVC.setSubject(lecture)
        return mailComposerVC
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MyScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myEventCell", for: indexPath) as! MyEventTableViewCell
        cell.delegate = self
        cell.lecture = self.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MyEventTableViewCell else { return }
        let mailComposerVC = self.configuredMailComposeViewController(lecture: (cell.lecture?.lecture)!)
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposerVC, animated: true, completion: nil)
        }
    }
}

// MARK: - MyEventTableViewCellDelegate

extension MyScheduleViewController: MyEventTableViewCellDelegate {
    func didTapOpenOnMap(lecture: String) {
        self.delegate?.didTapCellOpenOnMap(lecture: lecture)
    }
}

// MARK: - MFMailComposeViewControllerDelegate

extension MyScheduleViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
