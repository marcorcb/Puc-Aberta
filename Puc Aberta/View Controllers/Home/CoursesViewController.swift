//
//  CoursesViewController.swift
//  Puc Aberta
//
//  Created by Marco Braga on 03/03/18.
//  Copyright © 2018 Marco Braga. All rights reserved.
//

import UIKit
import MBProgressHUD

class CoursesViewController: BaseViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var webView: UIWebView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: - Private

    func setup() {
        let requestURL = URL(string: "https://www.pucminas.br/Graduacao/Paginas/default.aspx")
        let request = URLRequest(url: requestURL!)
        self.webView.delegate = self
        self.webView.loadRequest(request)
    }
}

// MARK: - UIWebViewDelegate

extension CoursesViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
