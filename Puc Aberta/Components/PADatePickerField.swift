//
//  PADatePickerField.swift
//  Puc Aberta
//
//  Created by Marco Braga on 01/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

protocol PADatePickerDelegate: class {
    func didChangeDate(on: PADatePickerField)
}

class PADatePickerField: PATextField {

    weak var datePickerDelegate: PADatePickerDelegate?
    var pickerView: UIDatePicker!
    let dateFormatter = DateFormatter()

    func setDates(maximumDate: Date?, minimumDate: Date?) {
        self.tintColor = .clear
        self.pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 216))
        self.pickerView.datePickerMode = .date
        self.pickerView.locale = Locale.current
        self.pickerView.calendar = Calendar.current
        self.pickerView.timeZone = TimeZone.current
        self.dateFormatter.locale = Locale.current
        self.dateFormatter.dateStyle = .short

        if maximumDate != nil {
            self.pickerView.maximumDate = maximumDate
        }

        if minimumDate != nil {
            self.pickerView.minimumDate = minimumDate
        }

        self.inputView = self.pickerView
        self.pickerView.addTarget(self, action: #selector(dateChanged), for: UIControl.Event.valueChanged)
    }

    @objc func dateChanged() {
        self.text = self.dateFormatter.string(from: self.pickerView.date)
        self.datePickerDelegate?.didChangeDate(on: self)
    }
}
