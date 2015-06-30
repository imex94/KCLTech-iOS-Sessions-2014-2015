//
//  UIPathFollower.swift
//  session208
//
//  Created by Clarence Ji on 1/26/15.
//  Copyright (c) 2015 Clarence Ji. All rights reserved.
//

import UIKit

class UIPathFollower: UIImageView {

    func startAnimate(parent: UIViewController) {
        image = UIImage(named: "satellite")
        hidden = false
        bounds.size.width = 100
        bounds.size.height = 100
        center = parent.view.center
        
        var animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = CGPathCreateWithEllipseInRect(CGRectMake(-100, -100, 200, 200), nil)
        animation.duration = 10
        animation.repeatCount = 1000
        animation.calculationMode = kCAAnimationPaced
        animation.rotationMode = kCAAnimationRotateAuto
        animation.additive = true
        
        parent.view.addSubview(self)
        layer.addAnimation(animation, forKey: "rotateAnimation")
    }
    
    func stopAnimate() {
        var fadeOut = CABasicAnimation(keyPath: "opacity")
        fadeOut.toValue = 0.0
        fadeOut.duration = 2.0
        fadeOut.fillMode = kCAFillModeForwards
        fadeOut.removedOnCompletion = false
        self.layer.addAnimation(fadeOut, forKey: "fadeout")
    }


}
