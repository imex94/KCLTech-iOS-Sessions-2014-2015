//
//  TexxtFieldViewController.swift
//  session208
//
//  Created by Clarence Ji on 1/26/15.
//  Copyright (c) 2015 Clarence Ji. All rights reserved.
//

import UIKit
import QuartzCore

class TexxtFieldViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.validate()
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITextField {
    
    func validate() -> Bool {
        
        if text != "admin" {
            
            var animation = CAKeyframeAnimation(keyPath: "transition")
            animation.duration = 0.4
            
            animation.values = [NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, 0.0, 0.0)),NSValue(CATransform3D: CATransform3DMakeTranslation(10.0, 0.0, 0.0)), NSValue(CATransform3D: CATransform3DMakeTranslation(-10.0, 0.0, 0.0)), NSValue(CATransform3D: CATransform3DMakeTranslation(0.0, 0.0, 0.0))]
            
            layer.addAnimation(animation, forKey: "shake")
            
            return false
        }
        return true
    }
    
}