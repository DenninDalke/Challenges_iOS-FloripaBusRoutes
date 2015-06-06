//
//  LoadingView.swift
//  FloripaBusRoutes
//
//  Created by Dennin Dalke on 05/03/15.
//  Copyright (c) 2015 Dennin Dalke. All rights reserved.
//

import UIKit

private var loading:UIView!

class LoadingView: UIView
{
    class func show(view:UIView)
    {
        if let ld = loading
        {
            if (ld.superview?.isEqual(view) != nil)
            {
                return
            }
        }
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        indicator.startAnimating()
        loading = UIView(frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height+view.frame.origin.y))
        indicator.center = CGPointMake(loading.frame.size.width/2, loading.frame.size.height/2)
        loading.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.35)
        loading.addSubview(indicator)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        dispatch_async(dispatch_get_main_queue())
        {
            if let loadingView = loading as UIView?
            {
                view.addSubview(loading)
            }
        }
    }
    class func hide()
    {
        dispatch_async(dispatch_get_main_queue())
        {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if let loadingView = loading
            {
                loading.removeFromSuperview()
                loading = nil
            }
        }
    }

}
