//
//  ViewController.swift
//  session208
//
//  Created by Clarence Ji on 1/26/15.
//  Copyright (c) 2015 Clarence Ji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //var loadingIndicator = UILoadingIndicator()
    var satellite = UIPathFollower()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        loadingIndicator.startAnimate(self)
//        
        NSTimer.scheduledTimerWithTimeInterval(10.0, target: self, selector: Selector("callThis"), userInfo: nil, repeats: false)
        satellite.startAnimate(self)
        
    }
    
    func callThis() {
        satellite.stopAnimate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

