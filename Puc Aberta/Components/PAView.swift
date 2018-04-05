//
//  PAView.swift
//  Puc Aberta
//
//  Created by Marco Braga on 20/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

@IBDesignable
class PAView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = true
        }
    }
    
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
}
