//
//  PAAlertController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 01/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import pop

struct PAAlertAction {

    let title: String
    var handler: (() -> Void)?

    init(title: String, handler: (() -> Void)? = nil) {

        self.title = title
        self.handler = handler
    }
}

class PAAlertButton: UIButton {
    var action: PAAlertAction?
}

class PAAlertController: UIViewController {

    fileprivate struct Constants {
        struct Overlay {
            static let alpha = 0.49 as CGFloat
        }

        struct AlertView {
            static let width = 300 as CGFloat
            static let minimumHeight = 150 as CGFloat
            static let cornerRadius = 10 as CGFloat
        }

        struct TitleLabel {
            static let topMargin = 33 as CGFloat
        }

        struct MessageLabel {
            static let topMargin = 22 as CGFloat
            static let horizontalMargin = 45 as CGFloat
            static let lineSpacing = 7 as CGFloat
        }

        struct ActionButton {
            static let cornerRadius = 0 as CGFloat
            static let topMargin = 10 as CGFloat
            static let bottomMargin = 23 as CGFloat
            static let verticalButtonHorizontalMargin = 20 as CGFloat
            static let horizontalButtonHorizontalMargin = 15 as CGFloat
            static let height = 40 as CGFloat
        }

        struct Animation {
            static let springBounciness = 6 as CGFloat
            static let duration = 0.4 as TimeInterval
        }
    }

    var titleImage: UIImage?
    var alertMessage: String?
    var actions: [PAAlertAction] = []

    fileprivate var overlayView: UIView!
    fileprivate var alertViewContainer: UIView!
    fileprivate var alertStackView: UIStackView!

    fileprivate var widthConstraint: NSLayoutConstraint!
    private var originalWidth: CGFloat!
    private var heightConstraint: NSLayoutConstraint!
    private var originalHeight: CGFloat!

    private var selectedButton: PAAlertButton?

    convenience init(titleImage: UIImage?, message: String, actions: [PAAlertAction] = []) {
        self.init()

        self.modalPresentationStyle = .overFullScreen

        self.titleImage = titleImage
        self.alertMessage = message

        if actions.count == 0 {
            let okAction = PAAlertAction(title: NSLocalizedString("OK", comment: ""))
            self.actions = [okAction]
        } else {
            self.actions = actions
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupOverlay()
        self.setupAlertView()
        self.setupTitleImage()
        self.setupMessageLabel()
        self.setupActions()
        self.setupAnimation()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let widthAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        widthAnimation?.toValue = self.originalWidth
        widthAnimation?.springBounciness = Constants.Animation.springBounciness
        self.widthConstraint.pop_add(widthAnimation, forKey: "widthAnimation")

        let heightAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        heightAnimation?.toValue = self.originalHeight
        heightAnimation?.springBounciness = Constants.Animation.springBounciness
        self.heightConstraint.pop_add(heightAnimation, forKey: "heightAnimation")

        UIView.animate(withDuration: Constants.Animation.duration) {
            self.overlayView.alpha = Constants.Overlay.alpha
        }
    }

    func setupAnimation() {

        self.view.layoutIfNeeded()

        self.originalWidth = self.alertStackView.frame.size.width
        self.originalHeight = self.alertStackView.frame.size.height

        self.heightConstraint = NSLayoutConstraint(item: self.alertViewContainer, attribute: .height, relatedBy: .equal,
                                                   toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        self.widthConstraint.constant = 0
        self.alertViewContainer.addConstraints([self.heightConstraint])
    }

    func dismiss() {

        let widthAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        widthAnimation?.toValue = 0
        widthAnimation?.springBounciness = Constants.Animation.springBounciness
        widthAnimation?.clampMode = POPAnimationClampFlags.both.rawValue
        self.widthConstraint.pop_add(widthAnimation, forKey: "widthAnimation")

        let heightAnimation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        heightAnimation?.toValue = 0
        heightAnimation?.springBounciness = Constants.Animation.springBounciness
        heightAnimation?.clampMode = POPAnimationClampFlags.both.rawValue
        self.heightConstraint.pop_add(heightAnimation, forKey: "heightAnimation")

        UIView.animate(withDuration: Constants.Animation.duration, animations: {
            self.overlayView.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: false, completion: nil)
            self.selectedButton?.action?.handler?()
        })
    }

    @objc func backgroundTapHandler() {

        if self.actions.count == 1 {
            self.actions.first?.handler?()
        }

        self.dismiss()
    }

    @objc func actionHandler(sender: PAAlertButton) {
        self.selectedButton = sender
        self.dismiss()
    }
}

// MARK: - UI Setup

extension PAAlertController {

    fileprivate func setupOverlay() {

        self.overlayView = UIView()
        self.overlayView.backgroundColor = UIColor.black
        self.overlayView.alpha = 0
        self.overlayView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.overlayView)

        let tapToDismissGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                   action: #selector(backgroundTapHandler))
        self.overlayView.addGestureRecognizer(tapToDismissGestureRecognizer)

        let leftConstraint = NSLayoutConstraint(item: self.overlayView, attribute: .left, relatedBy: .equal,
                                                toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self.overlayView, attribute: .top, relatedBy: .equal,
                                               toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.overlayView, attribute: .right, relatedBy: .equal,
                                                 toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.overlayView, attribute: .bottom, relatedBy: .equal,
                                                  toItem: self.view, attribute: .bottom, multiplier: 1, constant: 0)
        self.view.addConstraints([leftConstraint, topConstraint, rightConstraint, bottomConstraint])
    }

    fileprivate func setupAlertView() {
        self.setupAlertViewContainer()
        self.setupAlertStackView()
    }
    func setupAlertViewContainer() {
        self.alertViewContainer = UIView()
        self.alertViewContainer.layer.cornerRadius = Constants.AlertView.cornerRadius
        self.alertViewContainer.layer.shadowColor = UIColor.black.cgColor
        self.alertViewContainer.layer.shadowRadius = 12
        self.alertViewContainer.layer.shadowOpacity = 0.4
        self.alertViewContainer.layer.shadowOffset = CGSize(width: 0, height: 9)
        self.alertViewContainer.layer.masksToBounds = false
        self.alertViewContainer.backgroundColor = UIColor.white
        self.alertViewContainer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.alertViewContainer)

        let centerXConstraint = NSLayoutConstraint(item: self.alertViewContainer, attribute: .centerX,
                                                   relatedBy: .equal, toItem: self.view, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        let centerYConstraint = NSLayoutConstraint(item: self.alertViewContainer, attribute: .centerY,
                                                   relatedBy: .equal, toItem: self.view, attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        self.widthConstraint = NSLayoutConstraint(item: self.alertViewContainer, attribute: .width,
                                                  relatedBy: .equal, toItem: nil, attribute: .notAnAttribute,
                                                  multiplier: 1, constant: Constants.AlertView.width)
        let minimumHeightConstraint = NSLayoutConstraint(item: self.alertViewContainer, attribute: .height,
                                                         relatedBy: .greaterThanOrEqual, toItem: nil,
                                                         attribute: .notAnAttribute, multiplier: 1,
                                                         constant: Constants.AlertView.minimumHeight)
        minimumHeightConstraint.priority = UILayoutPriority(rawValue: 999)
        self.alertViewContainer.addConstraints([self.widthConstraint, minimumHeightConstraint])
        self.view.addConstraints([centerXConstraint, centerYConstraint])
    }

    func setupAlertStackView() {
        self.alertStackView = UIStackView()
        self.alertStackView.axis = .vertical
        self.alertStackView.spacing = 24
        self.alertStackView.layoutMargins = UIEdgeInsets(top: 28, left: 20, bottom: 10, right: 20)
        self.alertStackView.isLayoutMarginsRelativeArrangement = true
        self.alertStackView.translatesAutoresizingMaskIntoConstraints = false
        self.alertViewContainer.addSubview(self.alertStackView)

        let leftConstraint = NSLayoutConstraint(item: self.alertStackView, attribute: .left, relatedBy: .equal,
                                                toItem: self.alertViewContainer, attribute: .left,
                                                multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self.alertStackView, attribute: .top, relatedBy: .equal,
                                               toItem: self.alertViewContainer, attribute: .top,
                                               multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.alertStackView, attribute: .right, relatedBy: .equal,
                                                 toItem: self.alertViewContainer, attribute: .right,
                                                 multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.alertStackView, attribute: .bottom, relatedBy: .equal,
                                                  toItem: self.alertViewContainer, attribute: .bottom,
                                                  multiplier: 1, constant: 0)
        self.alertViewContainer.addConstraints([leftConstraint, topConstraint, rightConstraint, bottomConstraint])
    }

    fileprivate func setupTitleImage() {
        guard let titleImage = self.titleImage else { return }

        let containerView = UIView()
        let imageView = UIImageView(image: titleImage)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)

        let centerXConstraint = NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal,
                                                   toItem: containerView, attribute: .centerX,
                                                   multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: imageView, attribute: .top, relatedBy: .equal,
                                               toItem: containerView, attribute: .top,
                                               multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal,
                                                  toItem: containerView, attribute: .bottom,
                                                  multiplier: 1, constant: 0)
        containerView.addConstraints([centerXConstraint, topConstraint, bottomConstraint])

        self.alertStackView.addArrangedSubview(containerView)
    }

    fileprivate func setupMessageLabel() {

        let label = UILabel()
        label.font = UIFont(name: "Avenir-Light", size: 19.5)
        label.textColor = #colorLiteral(red: 0.08235294118, green: 0.2549019608, blue: 0.3647058824, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = self.alertMessage
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 752), for: .vertical)
        self.alertStackView.addArrangedSubview(label)
    }

    fileprivate func setupActions() {
        let buttonsStackView = UIStackView()
        buttonsStackView.axis = .horizontal
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        for action in self.actions {
            let button = PAAlertButton(type: .system)
            button.titleLabel?.font = UIFont(name: "Avenir-Black", size: 17)
            button.setTitleColor(#colorLiteral(red: 0.08235294118, green: 0.2549019608, blue: 0.3647058824, alpha: 1), for: .normal)
            button.setTitle(action.title, for: .normal)
            button.addTarget(self, action: #selector(actionHandler(sender:)), for: .touchUpInside)
            button.layer.cornerRadius = Constants.ActionButton.cornerRadius
            button.action = action
            buttonsStackView.addArrangedSubview(button)
        }
        self.alertStackView.addArrangedSubview(buttonsStackView)
    }
}
