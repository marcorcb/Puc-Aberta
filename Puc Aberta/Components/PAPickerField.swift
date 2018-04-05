//
//  PAPickerField.swift
//  Puc Aberta
//
//  Created by Marco Braga on 04/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class PAPickerItem {
    var title: String
    var data: Any?
    
    init(title: String, data: Any?) {
        self.title = title
        self.data = data
    }
}

protocol PAPickerFieldDelegate: class {
    func didSelect(item: PAPickerItem, on pickerField: PAPickerField)
    func didSelectEmpty(on pickerField: PAPickerField)
}

class PAPickerField: UITextField {
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }
    
    weak var pickerDelegate: PAPickerFieldDelegate?
    var items: [PAPickerItem] = []
    var pickerView: UIPickerView!
    var selectedItem: PAPickerItem? {
        get {
            let index = self.pickerView.selectedRow(inComponent: 0)
            
            if index == 0 {
                return nil
            }
            
            return self.items[index - 1]
        }
        
        set {
            if let selectedItem = newValue {
                guard let index = self.items.index(where: { $0 === selectedItem}) else { return }
                self.pickerView.selectRow(index + 1, inComponent: 0, animated: true)
                self.text = selectedItem.title
            } else {
                self.text = nil
                self.pickerView.selectRow(0, inComponent: 0, animated: true)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initConfig()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initConfig()
    }
    
    func initConfig() {
        self.tintColor = .clear
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 216))
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.inputView = self.pickerView
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}

extension PAPickerField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.items.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            return ""
        }
        
        let item = self.items[row - 1]
        return item.title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if row == 0 {
            self.text = ""
            self.pickerDelegate?.didSelectEmpty(on: self)
            return
        }
        
        let item = self.items[row - 1]
        self.text = item.title
        self.pickerDelegate?.didSelect(item: item, on: self)
    }
}


