//
//  MyEventTableViewCell.swift
//  Puc Aberta
//
//  Created by Marco Braga on 23/04/2018.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

protocol MyEventTableViewCellDelegate: class {
    func didTapOpenOnMap(lecture: String)
}

class MyEventTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var eventIconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    // MARK: - Members
    
    weak var delegate: MyEventTableViewCellDelegate?
    var lecture: Lecture? {
        didSet {
            self.setupUI()
        }
    }
    
    // MARK: - Private
    
    func setupUI() {
        guard let lecture = self.lecture else { return }
        self.titleLabel.text = lecture.lecture
        self.locationLabel.text = lecture.location
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM - HH:mm"
        self.timeLabel.text = dateFormatter.string(from: lecture.date!)
    }
    
    // MARK: - IBActions
    
    @IBAction func openOnMap(_ sender: Any) {
        guard let lecture = self.lecture else { return }
        self.delegate?.didTapOpenOnMap(lecture: lecture.lecture!)
    }
}
