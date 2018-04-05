//
//  BaseTableViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
protocol BaseTableViewControllerDelegate: class {
    func viewControllerDidExit(_ viewController: UIViewController)
}

class BaseTableViewController: UITableViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    weak var baseDelegate: BaseTableViewControllerDelegate?
    
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
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

