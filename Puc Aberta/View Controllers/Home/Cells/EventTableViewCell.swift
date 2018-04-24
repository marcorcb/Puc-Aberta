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
    @IBOutlet weak var scheduleImageView: UIImageView!
    
    // MARK: - Members
    
    var event: Event? {
        didSet {
            self.setupUI()
        }
    }
    
    // MARK: - Private
    
    func setupUI() {
        guard let event = self.event else { return }
        let group = "Grupo " + event.group
        self.titleLabel.text = group + " - " + event.description
        self.scheduleImageView.image = UIImage(named: event.image)
    }
}
