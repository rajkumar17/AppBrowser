//
//  HomeViewController.swift
//  AppBrowserTest
//
//  Created by Terralogic on 6/19/20.
//  Copyright © 2020 Terralogic. All rights reserved.
//

import UIKit
import WebKit


class HomeViewController: BaseViewController {
     @IBOutlet weak var searchTextField: UITextField!
        var myActivityIndicator = UIActivityIndicatorView()
        var webView: WKWebView!
        private let customIndicatorLoading = CustomLoadingViewExtension()
        private var reachability = Reachability()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            self.title = "App Browser"
            webView = WKWebView()
            webView.navigationDelegate = self
            webView.allowsBackForwardNavigationGestures = true
        }
        
        //Mark: Search Using google query url
        @IBAction func btnClickAction(_ sender: UIButton){
            self.loadingViewShowAndHide = true
            
            if reachability.isNetworkReachable() == true{
                if let urlString = searchTextField.text, urlString != ""{
                    if isStringLink(string:urlString){
                        isValidateWebUrl(urlString:urlString)
                    }else{
                        self.present(AppUtils.showAlert(titleContent: "App Alert", msg:"Please enter a valid WebSite URL."), animated: true, completion: nil)
                        self.loadingViewShowAndHide = false
                    }
                }else{
                    self.present(AppUtils.showAlert(titleContent: "App Alert", msg:"Please enter a valid WebSite URL."), animated: true, completion: nil)
                    self.loadingViewShowAndHide = false
                }
            }else{
                
                self.present(AppUtils.showAlert(titleContent: "App Alert", msg:"Please check your connection and try again."), animated: true, completion: nil)
                self.loadingViewShowAndHide = false
            }
        }
        func isStringLink(string: String) -> Bool {
            let types: NSTextCheckingResult.CheckingType = [.link]
            let detector = try? NSDataDetector(types: types.rawValue)
            guard (detector != nil && string.count > 0) else { return false }
            if detector!.numberOfMatches(in: string, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, string.count)) > 0 {
                return true
            }
            return false
        }
        func isValidateWebUrl(urlString:String){
            if urlString != ""{
                if urlString.starts(with: "http://") || urlString.starts(with: "https://"){
                          let url = URL(string: urlString)!
                          webView.load(URLRequest(url: url))
                      }else if urlString.contains("www"){
                           let url = URL(string:"http://\(urlString)")!
                            webView.load(URLRequest(url: url))
                      }else{
                          searchTextOnGoogle(text: urlString)
                        self.loadingViewShowAndHide = false
                  }
            }
        }
        func searchTextOnGoogle(text: String){
            let textComponent = text.components(separatedBy: " ")
            let searchString = textComponent.joined(separator: "+")
            let url = URL(string: "https://www.google.com/search?q=" + searchString)
            let urlRequest = URLRequest(url: url!)
            webView.load(urlRequest)
        }
    }
    extension HomeViewController:WKNavigationDelegate{

        //MARK:- WKNavigationDelegate
        private func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
            print(error.localizedDescription)
            self.loadingViewShowAndHide = false
        }
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    //        print("Strat to load = \(String(describing: webView.url!))")
            self.loadingViewShowAndHide = false
            self.navigateWebViewController(url: webView.url!)
        }
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            //print("finish to load = \(String(describing: webView.url!))")
            self.loadingViewShowAndHide = false
        }
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!){
    //        print("didCommit to load = \(String(describing: webView.url!))")
        }
    }
