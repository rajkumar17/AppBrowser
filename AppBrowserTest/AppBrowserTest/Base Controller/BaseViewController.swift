//
//  BaseViewController.swift
//  AppBrowserTest
//
//  Created by Terralogic on 6/19/20.
//  Copyright © 2020 Terralogic. All rights reserved.
//

import UIKit
import WebKit

class BaseViewController: UIViewController {

    private let customIndicatorLoading = CustomLoadingViewExtension()
       private var isLoadingViewShowAndHide:Bool = false
       
       
       public var loadingViewShowAndHide: Bool{
              set{
                  if newValue{   //Will Show
                      isLoadingViewShowAndHide = newValue
                      customIndicatorLoading.showActivityIndicator(uiView: self.view)
                      
                  } else { //Not Hide
                      customIndicatorLoading.hideActivityIndicator(uiView: self.view)
                  }
              }
              get {return self.isLoadingViewShowAndHide}
          }
       
       override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
       }

       func navigateWebViewController(url:URL){
             let storyboard = UIStoryboard(name: "Main", bundle: nil)
             let viewController = storyboard.instantiateViewController(identifier: "WebViewID") as WebViewController
             viewController.webUrl = url
             self.navigationController!.pushViewController(viewController, animated: true)
       }
}
