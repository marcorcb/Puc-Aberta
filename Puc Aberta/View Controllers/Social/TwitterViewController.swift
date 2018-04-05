//
//  SocialViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 21/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import MBProgressHUD

class TwitterViewController: BaseViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var webView: UIWebView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Private

    func setup() {
        let htmlPath = Bundle.main.url(forResource: "twitterLive", withExtension: "html")
        let request = URLRequest.init(url: htmlPath!)
        self.webView.loadRequest(request)
    }
}
