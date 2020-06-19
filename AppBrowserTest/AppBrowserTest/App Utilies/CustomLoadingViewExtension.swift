//
//  CustomLoadingViewExtension.swift
//  AppBrowserTest
//
//  Created by Terralogic on 6/19/20.
//  Copyright © 2020 Terralogic. All rights reserved.
//

import UIKit

class CustomLoadingViewExtension: UIView {

    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var lblLoadingTitle = UILabel()
    
    //MARK:-- Show Loading View
    func showActivityIndicator(uiView: UIView) {
        
        //uiView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.5)
        
        container.frame =  UIScreen.main.bounds//uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.5) // 0xffffff 0.3
        container.tag = 10001
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator = UIActivityIndicatorView.init(style:UIActivityIndicatorView.Style.large)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        
        lblLoadingTitle = UILabel(frame: CGRect(x: 0, y: activityIndicator.frame.origin.y + activityIndicator.frame.size.height+20, width: loadingView.frame.size.width, height: 25))
        
        lblLoadingTitle.text = "Loading..."
        lblLoadingTitle.textColor = .white
        lblLoadingTitle.font = UIFont(name: "Helvetica", size: 18)
        //To display multiple lines in label
        lblLoadingTitle.numberOfLines = 0
        lblLoadingTitle.lineBreakMode = .byWordWrapping
        //lblLoadingTitle.sizeToFit()//If required
        lblLoadingTitle.backgroundColor = .clear
        lblLoadingTitle.textAlignment = .center //For center alignment
        
        loadingView.addSubview(activityIndicator)
        loadingView.addSubview(lblLoadingTitle)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    /*
     Hide activity indicator
     Actually remove activity indicator from its super view
     @param uiView - remove activity indicator from this view
     */
    func hideActivityIndicator(uiView: UIView) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.container.removeFromSuperview()
            //uiView.backgroundColor = UserDefaults.standard.colorForKey(key: "flag_CurrentColor_Code")
        }
    }
    
    /*
     Define UIColor from hex value
     
     @param rgbValue - hex color value
     @param alpha - transparency level
     */
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
