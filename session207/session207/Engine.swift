//
//  Engine.swift
//  session207
//
//  Created by Alex Telek on 19/01/2015.
//  Copyright (c) 2015 Alex Telek. All rights reserved.
//

import UIKit
import CoreData

class Engine: NSObject {
   
    // Return all the objects from the entity based on a predicate
    class func findAllObjects(entityName: String, predicate: NSPredicate?) -> Array<AnyObject>? {
        let managedObjectContext = defaultManagedObjcetContext()!
        
        var fetchRequest = NSFetchRequest()
        fetchRequest.entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: managedObjectContext)
        fetchRequest.predicate = predicate
        
        var error: NSError?
        let results = managedObjectContext.executeFetchRequest(fetchRequest, error: &error)
        
        if results == nil {
            return nil
        }  else {
            return results
        }
    }
    
    // Getting the same managed object context throughout the code
    class func defaultManagedObjcetContext() -> NSManagedObjectContext? {
        var managedObjectContext: NSManagedObjectContext?
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if (appDelegate.respondsToSelector(Selector("managedObjectContext"))) {
            managedObjectContext = appDelegate.managedObjectContext
        }
        
        return managedObjectContext
    }
    
    class func saveEntity() -> Bool {
        let managedObjectContext = defaultManagedObjcetContext()
        var error: NSError?
        
        if (defaultManagedObjcetContext()?.save(&error)) != nil {
            return false
        }
        
        return true
    }
}