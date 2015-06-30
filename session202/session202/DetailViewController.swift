//
//  DetailViewController.swift
//  session202
//
//  Created by Alex Telek on 10/11/2014.
//  Copyright (c) 2014 KCLTech. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var note: Note?
    
    @IBOutlet var lblUserName: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the Font type and the foreground color of the navigationcontroller bar
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationBar.titleTextAttributes = Dictionary(dictionaryLiteral: (NSForegroundColorAttributeName, UIColor.whiteColor()), (NSFontAttributeName, UIFont(name: "HelveticaNeue-Light", size: 16.0)!))
        
        //set the title of the navigation bar
        navigationController?.navigationBar.topItem?.title = "Note Details"
        
        //set the background color of the navigation bar
        navigationController?.navigationBar.barTintColor = UIColor(red: 15/255, green: 36/255, blue: 156/255, alpha: 1.0)
        
        if let user = note?.user {
            lblUserName.text = user.username
        } else {
            lblUserName.text = "Anonymous"
        }
        lblDate.text = note?.getCreatedAt()
        lblText.text = note?.noteText
    }
}
