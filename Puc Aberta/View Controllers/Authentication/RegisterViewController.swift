//
//  RegisterViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 21/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import MBProgressHUD

class RegisterViewController: BaseViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - Members
    
    var registerURL: URL?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Private
    
    func setup() {
        guard let registerURL = self.registerURL else { return }
        let request = URLRequest.init(url: registerURL)
        self.webView.delegate = self
        self.webView.loadRequest(request)
    }
}

// MARK: - UIWebViewDelegate

extension RegisterViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
