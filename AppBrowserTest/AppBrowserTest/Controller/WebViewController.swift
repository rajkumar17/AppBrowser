//
//  WebViewController.swift
//  AppBrowserTest
//
//  Created by Terralogic on 6/19/20.
//  Copyright © 2020 Terralogic. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController,WKNavigationDelegate {
    @IBOutlet var webView : WKWebView!
        var webUrl: URL!
        
        override func viewDidLoad(){
            super.viewDidLoad()
            self.title = "Web Browser"
            // Do any additional setup after loading the view.
            webView.navigationDelegate = self
            webView.allowsBackForwardNavigationGestures = true
            webView.load(URLRequest(url: webUrl))
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
               if let urlStr = navigationAction.request.url?.absoluteString {
                   //urlStr is what you want
                   print("------------ = \(urlStr)");
                   print(urlStr);
                   if urlStr.contains("youtube.com") {
                       webView.loadHTMLString("<html><body><center><h1> This page can't be loaded </h1></center></body></html>", baseURL: nil)
                   }
               }
               decisionHandler(.allow)
           }
    }

    extension WKWebView {
        func load(_ urlString: String) {
            if let url = URL(string: urlString) {
                let request = URLRequest(url: url)
                load(request)
            }
        }
        
        
    }
