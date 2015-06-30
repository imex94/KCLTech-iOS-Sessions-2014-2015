//
//  LoginViewController.swift
//  session202
//
//  Created by Alex Telek on 10/11/2014.
//  Copyright (c) 2014 KCLTech. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        // load user from local storage and load up its notes        
        if let user = Store.loadData(txtUsername.text) {
            performSegueWithIdentifier("login", sender: self)
        } else {
            println("No user has been found, please signup!")
        }
        txtUsername.resignFirstResponder()
        txtPassword.resignFirstResponder()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "login") {
            let nav = segue.destinationViewController as! UINavigationController
            let nextView = nav.topViewController as! NotesTableViewController
            nextView.currentUser = Store.loadData(txtUsername.text)
        }
    }
    

}
