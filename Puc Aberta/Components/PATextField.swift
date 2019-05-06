//
//  PATextField.swift
//  Puc Aberta
//
//  Created by Marco Braga on 01/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

@IBDesignable
class PATextField: JMMaskTextField {
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

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initConfig()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initConfig()
    }

    func initConfig() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
}
