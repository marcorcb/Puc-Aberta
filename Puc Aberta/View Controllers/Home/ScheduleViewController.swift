//
//  ScheduleViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class ScheduleViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var unityPickerField: PAPickerField!
    @IBOutlet weak var eventPeriodLabel: UILabel!
    
    // MARK: - Members
    
    private let schedulePresenter = SchedulePresenter()
    fileprivate var units = [Unit]()
    fileprivate var dataSource = [Event]() {
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
        self.unityPickerField.items = [PAPickerItem(title: "Barreiro", data: "Barreiro"), PAPickerItem(title: "Betim", data: "Betim"), PAPickerItem(title: "Contagem", data: "Contagem"), PAPickerItem(title: "Coração Eucarístico", data: "Coração Eucarístico"), PAPickerItem(title: "Poços de Caldas", data: "Poços de Caldas"), PAPickerItem(title: "São Gabriel", data: "São Gabriel")]
        self.unityPickerField.pickerDelegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        self.schedulePresenter.attachView(self)
        self.schedulePresenter.setupJSON()
    }
    
    func setupUnity() {
        let index = self.units.index { (unit) -> Bool in
            return unit.name == self.unityPickerField.selectedItem?.data as? String
        }
        guard let unitIndex = index else { return }
        let unit = self.units[unitIndex]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.eventPeriodLabel.text = dateFormatter.string(from: unit.schedule.dates.first!) + " a " + dateFormatter.string(from: unit.schedule.dates.last!)
        self.dataSource = unit.schedule.events
    }
}

// MARK: - ScheduleProtocol

extension ScheduleViewController: ScheduleProtocol {
    func startLoading() {
        
    }
    
    func stopLoading() {
        
    }
    
    func showAlert(message: String) {
        self.present(PAAlertController(titleImage: #imageLiteral(resourceName: "icon_error"), message: message), animated: false, completion: nil)
    }
    
    func set(units: [Unit]) {
        self.unityPickerField.selectedItem = self.unityPickerField.items[3]
        self.unityPickerField.isUserInteractionEnabled = false
        self.units = units
        self.setupUnity()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        cell.event = self.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

// MARK: - PAPickerFieldDelegate

extension ScheduleViewController: PAPickerFieldDelegate {
    func didSelect(item: PAPickerItem, on pickerField: PAPickerField) {
        self.setupUnity()
    }
    
    func didSelectEmpty(on pickerField: PAPickerField) {
        self.unityPickerField.text = "Unidade"
    }
}
