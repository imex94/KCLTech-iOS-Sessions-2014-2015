//
//  Accounts.swift
//  HackLondon
//
//  Created by Alex Telek on 27/02/2015.
//  Copyright (c) 2015 KCLTech. All rights reserved.
//

import UIKit
import Accounts
import Social

class Accounts: UIViewController {

    @IBOutlet weak var lblTwitter: UILabel!
    @IBOutlet weak var txtTimeline: UITextView!
    
    var twitterAccount: ACAccount?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getTwitterUser()
        
    }
    
    func getTwitterUser() {
        let account = ACAccountStore()
        let accountType = account.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        account.requestAccessToAccountsWithType(accountType, options: nil, completion: {(success: Bool, error: NSError!) -> Void in
            if success {
                let arrayOfAccounts = account.accountsWithAccountType(accountType)
                
                if arrayOfAccounts.count > 0 {
                    self.twitterAccount = arrayOfAccounts.last as? ACAccount
                }
            }
        })
    }
    
    @IBOutlet weak var btnTwitter: UIButton!
    
    @IBAction func postOnTwitter(sender: AnyObject) {
        let requestURL = NSURL(string: "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=hacklondonuk&count=20")
        
        let postRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, URL: requestURL, parameters: nil)
        
        postRequest.account = twitterAccount
        
        postRequest.performRequestWithHandler( {(responseData: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) -> Void in
            if error == nil && responseData != nil {
                let json = NSJSONSerialization.JSONObjectWithData(responseData, options: .MutableContainers, error: nil) as! [AnyObject]
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    for tweet in json {
                        let text = tweet["text"] as! String
                        self.txtTimeline.text = self.txtTimeline.text.stringByAppendingString("\(text)\n\n")
                    }
                })
            }
        })
    }
    
}
