//
//  ViewController.swift
//  session206
//
//  Created by Alex Telek on 07/12/2014.
//  Copyright (c) 2014 Alex Telek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var customView: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        customView = NSBundle.mainBundle().loadNibNamed("CustomView", owner: self, options: nil).first as? CustomView
        
        let touch = UITapGestureRecognizer(target: self, action: Selector("dismissView:"))
        view.addGestureRecognizer(touch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addView(sender: AnyObject) {
        // 1.
        customView.frame.size.width = view.frame.size.width - 40
        customView.frame.size.height = view.frame.size.height / 2
        // 2.
        customView.center = CGPointMake(view.center.x - (view.frame.size.width), view.center.y)
        //customView.center = view.center
        // 3.
        customView.initWithDesign()
        customView.setWebPageTo("http://store.apple.com/us")
        // 4.
        view.addSubview(customView)
        
//        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
//            self.customView.center = self.view.center
//        }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: .CurveEaseOut, animations: { () -> Void in
            self.customView.center = self.view.center
        }, completion: nil)
    }
    
    func dismissView(gesture: UITapGestureRecognizer) {
        customView.removeFromSuperview()
    }
    
}

