//
//  UILoadingIndicator.swift
//  session208
//
//  Created by Clarence Ji on 1/26/15.
//  Copyright (c) 2015 Clarence Ji. All rights reserved.
//

import UIKit

class UILoadingIndicator: UIImageView {

    func startAnimate(parent: UIViewController) {
        image = UIImage(named: "loading_indicator")
        hidden = false
        bounds.size.width = 40
        bounds.size.height = 40
        center = parent.view.center
        
        var animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = NSNumber(double: M_PI * 2)
        animation.duration = 1.25
        animation.repeatCount = 100
        
        parent.view.addSubview(self)
        layer.addAnimation(animation, forKey: "rotateAnimation")
    }

    func stopAnimate() {
        layer.removeAllAnimations()
        hidden = true
    }
    
}
