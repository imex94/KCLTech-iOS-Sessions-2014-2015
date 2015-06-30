//
//  CustomTransition.swift
//  session209
//
//  Created by Alex Telek on 31/01/2015.
//  Copyright (c) 2015 Alex Telek. All rights reserved.
//

import UIKit

class CustomTransition: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var isPresenting: Bool!
    var presentDuration: NSTimeInterval!
    var dismissDuration: NSTimeInterval!
    
    // Later
    var source: UIButton!
    var transitionContext: UIViewControllerContextTransitioning!
    
    init(fromLocation source:UIButton) {
        super.init()
        
        presentDuration = 0.3
        dismissDuration = 0.3
        self.source = source
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        if isPresenting == true {
            return presentDuration
        }
        return dismissDuration
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting == true{
            presentController(transitionContext)
        } else {
            dismissController(transitionContext)
        }
        
    }
    
    func presentController(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        var containerView = transitionContext.containerView()
        
        var toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        if toViewController != nil {
            containerView.addSubview(toViewController!.view)
            
//            var centerFrom = containerView.center
//            centerFrom.x = containerView.frame.size.width * 1.5
//            toViewController!.view.center = centerFrom
//            
//            UIView.animateWithDuration(presentDuration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
//                toViewController!.view.center = containerView.center
//                }, completion: { (finished) -> Void in
//                    transitionContext.completeTransition(finished)
//            })
            
            //1 - define points
            var circleMaskPathInitial = UIBezierPath(ovalInRect: source.frame)
            var radius = source.center.y
            var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(source.frame, -radius, -radius))
            
            //2 - Cretate mask layer
            var maskLayer = CAShapeLayer()
            maskLayer.path = circleMaskPathFinal.CGPath
            toViewController!.view.layer.mask = maskLayer
            
            //3 - create the animation
            var maskLayerAnimation = CABasicAnimation(keyPath: "path")
            maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
            maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
            maskLayerAnimation.duration = self.transitionDuration(transitionContext)
            maskLayerAnimation.delegate = self
            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
        }
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        // Need to remove animations
        // Notify the views it's ended
        // set the mask to nil
        transitionContext!.completeTransition(flag)
        transitionContext!.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
    }
    
    func dismissController(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        var containerView = transitionContext.containerView()
        
        var fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        if fromViewController != nil {
            
//            var centerFrom = containerView.center
//            centerFrom.x = containerView.frame.size.width * 1.5
//            
//            UIView.animateWithDuration(dismissDuration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
//                fromViewController!.view.center = centerFrom
//                }, completion: { (finished) -> Void in
//                    transitionContext.completeTransition(finished)
//            })
            
            //1 - define points
            var circleMaskPathInitial = UIBezierPath(ovalInRect: source.frame)
            var radius = source.center.y
            var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(source.frame, -radius, -radius))
            
            //2 - Cretate mask layer
            var maskLayer = CAShapeLayer()
            maskLayer.path = circleMaskPathInitial.CGPath
            fromViewController!.view.layer.mask = maskLayer
            
            //3 - create the animation
            var maskLayerAnimation = CABasicAnimation(keyPath: "path")
            maskLayerAnimation.fromValue = circleMaskPathFinal.CGPath
            maskLayerAnimation.toValue = circleMaskPathInitial.CGPath
            maskLayerAnimation.duration = self.transitionDuration(transitionContext)
            maskLayerAnimation.delegate = self
            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
            
        }
    }
}
