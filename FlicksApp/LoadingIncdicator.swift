//
//  LoadingIncdicator.swift
//  FlicksApp
//
//  Created by Faisal Abu Jabal on 1/31/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class LoadingIndicator {
    
    private var activityIndicatorView = UIView()
    private let activityIndicator = UIActivityIndicatorView()
    private var container = UIView()
    
    func showIndicator(parentView view: UIView){
        
        let win: UIWindow = UIApplication.sharedApplication().delegate!.window!!
        activityIndicatorView = UIView(frame: win.frame)
        activityIndicatorView.tag = 1
        activityIndicatorView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0)
        
        win.addSubview(activityIndicatorView)
        
        container = UIView(frame: CGRect(x: 0, y: 0, width: win.frame.width/3, height: win.frame.width/3))
        container.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        container.layer.cornerRadius = 10.0
        container.layer.borderColor = UIColor.grayColor().CGColor
        container.layer.borderWidth = 0.5
        container.clipsToBounds = true
        container.center = activityIndicatorView.center
        
        
        activityIndicator.frame = CGRectMake(0, 0, win.frame.width/5, win.frame.width/5)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.center = activityIndicatorView.center
        
        activityIndicatorView.addSubview(container)
        activityIndicatorView.addSubview(activityIndicator)
        view.addSubview(activityIndicatorView)
        
        activityIndicator.startAnimating()
    }
    
    func hideIndicator(){
        UIView.animateWithDuration(0.0, delay: 1.0, options: .CurveEaseOut, animations: {
            self.container.alpha = 0.0
            self.activityIndicatorView.alpha = 0.0
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
            self.container.removeFromSuperview()
            self.activityIndicatorView.removeFromSuperview()
            let win:UIWindow = UIApplication.sharedApplication().delegate!.window!!
            let removeView  = win.viewWithTag(1)
            removeView?.removeFromSuperview()
        }, completion: { finished in
            
        })
    }
    
}
