//
//  Store.swift
//  session202
//
//  Created by Alex Telek on 09/11/2014.
//  Copyright (c) 2014 KCLTech. All rights reserved.
//

import UIKit

class Store {
    class func saveData(user: User) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let data = NSKeyedArchiver.archivedDataWithRootObject(user)
        userDefaults.setObject(data, forKey: user.username)
        userDefaults.synchronize()
    }
    
    class func loadData(username: String) -> User? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let userData = userDefaults.objectForKey(username) as? NSData {
            var user = NSKeyedUnarchiver.unarchiveObjectWithData(userData) as! User
            return user
        }
        return nil
    }
}