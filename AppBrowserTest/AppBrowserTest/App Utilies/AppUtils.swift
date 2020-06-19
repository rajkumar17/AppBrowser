//
//  AppUtils.swift
//  AppBrowserTest
//
//  Created by Terralogic on 6/19/20.
//  Copyright © 2020 Terralogic. All rights reserved.
//

import  UIKit

class AppUtils{
    
    //MARK:- Alert Method
       class func showAlert(titleContent: String, msg:String)->UIAlertController{
           let alertView = UIAlertController(title: titleContent, message: msg, preferredStyle: .alert)
           let action = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: { (alert) in
           })
           alertView.addAction(action)
           return alertView
       }
}
