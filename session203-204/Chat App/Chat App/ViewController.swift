//
//  ViewController.swift
//  Chat App
//
//  Created by Clarence Ji on 11/24/14.
//  Copyright (c) 2014 Clarence Ji. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var userNameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userNameTextfield.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if (textField.text != "") {
            
            Server.signup(textField.text, completitionClosure: { (success, content) -> () in
                if success {
                    userDefaults.setObject(textField.text, forKey: "current_user")
                    userDefaults.synchronize()
                self.performSegueWithIdentifier("segueToConversationTableVIewController", sender: self)
                } else {
                    println(content)
                }
            })
            
            return true
        }
        return false
    }
}

