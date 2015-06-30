//
//  CoreDataUser.swift
//  session207
//
//  Created by Alex Telek on 19/01/2015.
//  Copyright (c) 2015 Alex Telek. All rights reserved.
//

import Foundation
import CoreData

class CoreDataUser: NSManagedObject {

    @NSManaged var username: String
    @NSManaged var name: String
    @NSManaged var avatar_url: String
    @NSManaged var isFirstTime: Bool

}
