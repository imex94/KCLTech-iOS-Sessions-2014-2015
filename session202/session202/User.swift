//
//  User.swift
//  session202
//
//  Created by Alex Telek on 09/11/2014.
//  Copyright (c) 2014 KCLTech. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    var username = String()
    private var password = String()
    var email = String()
    var notes = Array<Note>()
    
    init(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
        
        println("User has been added")
    }
    
    //MARK: NSCoding class
    required init(coder aDecoder: NSCoder) {
        username = aDecoder.decodeObjectForKey("username") as! String
        password = aDecoder.decodeObjectForKey("password") as! String
        email = aDecoder.decodeObjectForKey("email") as! String
        notes = aDecoder.decodeObjectForKey("notes") as! Array<Note>
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(username, forKey: "username")
        aCoder.encodeObject(password, forKey: "password")
        aCoder.encodeObject(email, forKey: "email")
        aCoder.encodeObject(notes, forKey: "notes")
    }
    
    //MARK: methods
    func addNewNote(note: Note) {
        notes.append(note)
    }
    
    func getNoteByIndex(index: Int) -> Note {
        return notes[index]
    }
    
    func numberOfNotes() -> Int {
        return notes.count
    }
}
