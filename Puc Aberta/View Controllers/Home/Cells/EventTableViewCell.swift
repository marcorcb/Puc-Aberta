//
//  EventTableViewCell.swift
//  Puc Aberta
//
//  Created by Marco Braga on 14/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var coursesLabel: UILabel!
    @IBOutlet weak var subscribedEventImageView: UIImageView!
    
    // MARK: - Members
    
    var user: User? {
        didSet {
            self.setupUI()
        }
    }
    var event: Event? {
        didSet {
            self.setupUI()
        }
    }
    
    // MARK: - Private
    
    func setupUI() {
        guard let user = self.user else { return }
        guard let event = self.event else { return }
        let group = "Grupo " + event.group
        self.titleLabel.text = group + " - " + event.description + " - " + event.location
        self.timeLabel.text = event.startTime
        self.coursesLabel.text = event.courses.replacingOccurrences(of: ",", with: "\n")
        for lecture in user.lectures {
            if let lectureName = lecture.lecture, lectureName.hasPrefix(group) {
                self.subscribedEventImageView.isHidden = false
                return
            }
        }
        self.subscribedEventImageView.isHidden = true
    }
}
