//
//  SignupViewController.swift
//  session202
//
//  Created by Alex Telek on 10/11/2014.
//  Copyright (c) 2014 KCLTech. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signup(sender: AnyObject) {
        if let user = Store.loadData(txtUsername.text) {
            println("User already exist")
        } else {
            performSegueWithIdentifier("signup", sender: self)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nav = segue.destinationViewController as! UINavigationController
        let nextView = nav.topViewController as! NotesTableViewController
        let newUser = User(username: txtUsername.text, password: txtPassword.text, email: txtEmail.text)
        nextView.currentUser = newUser
        Store.saveData(newUser)
    }
}
