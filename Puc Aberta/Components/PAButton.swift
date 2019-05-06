//
//  PAButton.swift
//  Puc Aberta
//
//  Created by Marco Braga on 01/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

@IBDesignable
class PAButton: UIButton {

    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = self.borderColor?.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = self.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = self.cornerRadius
            self.layer.masksToBounds = true
        }
    }

    @IBInspectable var shadowColor: UIColor? {
        didSet {
            self.layer.shadowColor = shadowColor?.cgColor
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 0 {
        didSet {
            self.layer.shadowRadius = shadowRadius
            self.layer.masksToBounds = false
        }
    }

    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = shadowOpacity
        }
    }

    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            self.layer.shadowOffset = shadowOffset
        }
    }
}
