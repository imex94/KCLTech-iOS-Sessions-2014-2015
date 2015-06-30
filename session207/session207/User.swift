//
//  session207.swift
//  session207
//
//  Created by Alex Telek on 19/01/2015.
//  Copyright (c) 2015 Alex Telek. All rights reserved.
//

import Foundation
import CoreData

class User: NSManagedObject {

    @NSManaged var username: String
    @NSManaged var name: String
    @NSManaged var avatar_url: String
    @NSManaged var isFirstTime: NSNumber

    
    class func addUser(username: String, name: String, avatar_url: String) -> User {
        
        var user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: Engine.defaultManagedObjcetContext()!) as! User
        
        user.username = username
        user.name = name
        user.avatar_url = avatar_url
        user.isFirstTime = true
        
        return user
        
    }
}
