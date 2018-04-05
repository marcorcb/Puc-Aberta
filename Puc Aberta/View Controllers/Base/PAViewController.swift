//
//  PAViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 28/02/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit

protocol PAViewControllerDelegate: class {
    func viewControllerDidExit(_ viewController: UIViewController)
}

class PAViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    weak var baseDelegate: PAViewControllerDelegate?
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .portrait
    }
    
    static func initFromStoryboard(named storyboardName: String) -> Self {
        return initFromStoryboardHelper(storyboardName: storyboardName)
    }
    
    private class func initFromStoryboardHelper<T>(storyboardName: String) -> T {
        let storyoard = UIStoryboard(name: storyboardName, bundle: nil)
        let className = String(describing: self)
        let viewController = storyoard.instantiateViewController(withIdentifier: className) as! T
        return viewController
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if self.navigationController == nil {
            self.baseDelegate?.viewControllerDidExit(self)
        }
    }
}

