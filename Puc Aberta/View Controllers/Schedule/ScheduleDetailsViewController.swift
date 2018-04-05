//
//  ScheduleDetailsViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 19/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class ScheduleDetailsViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventSchedule: UILabel!
    @IBOutlet weak var coursesLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var subscribedEventViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Members
    
    var event: Event?
    var unit: Unit?
    var isSubscribed: Bool?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        guard let event = self.event else { return }
        guard let unit = self.unit else { return }
        guard let isSubscribed = self.isSubscribed else { return }
        let group = "Grupo " + event.group
        self.navigationItem.title = group
        self.eventTitle.text = group + " - " + event.description + " - " + event.location
        self.eventSchedule.text = event.startTime
        self.coursesLabel.text = event.courses.replacingOccurrences(of: ",", with: "\n")
        self.eventDescriptionLabel.text = unit.schedule.description
        self.subscribedEventViewHeightConstraint.constant = isSubscribed ? 36 : 0
        self.view.layoutIfNeeded()
    }
}
