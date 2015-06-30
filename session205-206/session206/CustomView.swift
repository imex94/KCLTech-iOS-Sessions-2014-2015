//
//  CustomView.swift
//  session206
//
//  Created by Alex Telek on 07/12/2014.
//  Copyright (c) 2014 Alex Telek. All rights reserved.
//

import UIKit

class CustomView: UIView {

    @IBOutlet weak var webView: UIWebView!
    
    func initWithDesign() {
        layer.cornerRadius = 5.0
        layer.shadowOffset = CGSizeMake(-0.2, 0.2)
        layer.shadowRadius = 1.5
        layer.shadowOpacity = 0.9
        layer.shadowColor = UIColor.grayColor().CGColor
        layer.shadowPath = UIBezierPath(rect: self.bounds).CGPath
    }
    
    func setWebPageTo(url: String) {
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
}
