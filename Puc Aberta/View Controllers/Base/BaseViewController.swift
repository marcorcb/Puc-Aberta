//
//  BaseViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 28/02/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

class BaseViewController: PAViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        guard let navigationController = self.navigationController else { return }
        
        self.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isTranslucent = false
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        if let navigationController = self.navigationController, navigationController.viewControllers.count > 1 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem.barButton(withImage: #imageLiteral(resourceName: "icon_back"), target: self, action: #selector(goBack))
            
            weak var weakNav = self.navigationController
            self.navigationController?.interactivePopGestureRecognizer?.delegate = weakNav as? UIGestureRecognizerDelegate
        }
    }
    
    @objc func goBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension UIBarButtonItem {
    
    static func barButton(withImage image: UIImage, target: Any?, action: Selector?) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.isUserInteractionEnabled = true
        button.setBackgroundImage(image, for: .normal)
        button.frame = CGRect(x: 0, y: 6, width: image.size.width, height: image.size.height)
        button.tintColor = UIColor.white
        
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }
        
        return UIBarButtonItem(customView: button)
    }
}

