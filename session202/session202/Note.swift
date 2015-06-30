//
//  Note.swift
//  session202
//
//  Created by Alex Telek on 09/11/2014.
//  Copyright (c) 2014 KCLTech. All rights reserved.
//

import UIKit

class Note: NSObject, NSCoding {
    var noteText = String()
    var date = NSDate()
    var user: User?
    
    //initialiser
    init(noteText: String, date: NSDate) {
        self.noteText = noteText
        self.date = date
    }
    
    //MARK: NSCoding class
    required init(coder aDecoder: NSCoder) {
        noteText = aDecoder.decodeObjectForKey("noteText") as! String
        date = aDecoder.decodeObjectForKey("date") as! NSDate
        user = aDecoder.decodeObjectForKey("user") as? User
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(noteText, forKey: "noteText")
        aCoder.encodeObject(date, forKey: "date")
        aCoder.encodeObject(user, forKey: "user")
    }
    
    //MARK: Methods
    func setEditor(user: User) {
        self.user = user
    }
    
    func getCreatedAt() -> String {
        let today = NSCalendar.currentCalendar().components((.CalendarUnitDay | .CalendarUnitMonth), fromDate: NSDate())
        let components = NSCalendar.currentCalendar().components((.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear | .CalendarUnitHour | .CalendarUnitMinute), fromDate: date)

        if (today.month == components.month && today.day == components.day) {
            return "\(components.hour):\(components.minute)"
        }
        
        return "\(components.year).\(components.month).\(components.day)"
    }
}
