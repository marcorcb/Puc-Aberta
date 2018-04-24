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
        let url = URL(string: "https://twitter.com/hashtag/PucAberta")
        let request = URLRequest.init(url: url!)
        self.webView.loadRequest(request)
    }
}
