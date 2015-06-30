//
//  ViewController.swift
//  session207
//
//  Created by Alex Telek on 19/01/2015.
//  Copyright (c) 2015 Alex Telek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let user = Engine.findAllObjects("User", predicate: nil)?.first as? User
        if user != nil {
            self.nameLabel.text = user!.name
        } else {
            Download.getDetails("imex94", completitionHandler: { (name, image, success) -> () in
                if success {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.nameLabel.text = name!
                        self.avatarImageView.image = image!
                    })
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

