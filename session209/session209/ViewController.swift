//
//  ViewController.swift
//  session209
//
//  Created by Alex Telek on 31/01/2015.
//  Copyright (c) 2015 Alex Telek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var manager: CustomTransition!
    @IBOutlet weak var btnNext: CustomView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager = CustomTransition(fromLocation: btnNext)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let toViewController = segue.destinationViewController as! UIViewController
        toViewController.modalPresentationStyle = .Custom
        toViewController.transitioningDelegate = manager
        
    }
    
}



