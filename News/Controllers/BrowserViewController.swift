//
//  BrowserViewController.swift
//  News
//
//  Created by Marcelo on 26/7/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {

    var webView: WKWebView!
    var webURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        guard let webURL = webURL, let url = URL(string: webURL) else {
            return
        }

        webView = WKWebView()
        webView.load(URLRequest(url: url))
        view = webView
    }

}
