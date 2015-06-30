//
//  Server.swift
//  Chat App
//
//  Created by Clarence Ji on 11/24/14.
//  Copyright (c) 2014 Clarence Ji. All rights reserved.
//

import Foundation

class Server {
    
    class func signup(username: String, completitionClosure: (success: Bool, content: NSDictionary?) -> ()){
        let url = NSURL(string: "https://kcltechchat.herokuapp.com/api/user/new")
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let body = "username=\(username)"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response, data, error) -> Void in
            if error == nil {
                var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                
                if jsonData != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: true, content: jsonData!)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: false, content: nil)
                    })
                }
            }
        }
    }
    
    class func createNewConversation(conversationName: String, username: String, completitionClosure: (success: Bool, content: NSDictionary?) -> ()) {
        let url = NSURL(string: "https://kcltechchat.herokuapp.com/api/conversation/new")
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let body = "username=\(username)&conversationName=\(conversationName)"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response, data, error) -> Void in
            if error == nil {
                var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                
                if jsonData != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: true, content: jsonData!)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: false, content: nil)
                    })
                }

            }
        }
        
    }
    
    class func subscribeToConversation(conversationID: String, username: String, completitionClosure: (success: Bool, content: NSDictionary?) -> ()) {
        let url = NSURL(string: "https://kcltechchat.herokuapp.com/api/conversation/\(conversationID)/subscribe")
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let body = "username=\(username)"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response, data, error) -> Void in
            if error == nil {
                var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                
                if jsonData != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: true, content: jsonData!)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: false, content: nil)
                    })
                }
            }
        }
    }
    
    class func sendNewMessage(conversationID: String, username: String, message: String, completitionClosure: (success: Bool, content: NSDictionary?) -> ()) {
        let url = NSURL(string: "https://kcltechchat.herokuapp.com/api/conversation/\(conversationID)/messages/new")
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        let body = "username=\(username)&message=\(message)"
        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response, data, error) -> Void in
            if error == nil {
                var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                
                if jsonData != nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: true, content: jsonData!)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: false, content: nil)
                    })
                }
            }
        }
    }
    
    class func getConversations(completitionClosure: (success: Bool, content: Array<String>?) -> ()) {
        var arrayToReturn: Array<String>?
        
        let url = NSURL(string: "https://kcltechchat.herokuapp.com/api/conversations")
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response, data, error) -> Void in
            if error == nil {
                var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                
                if jsonData != nil {
                    arrayToReturn = Array<String>()
                    let conversations = jsonData!.objectForKey("conversations") as! Array<NSDictionary>
                    for var i = 0;i < conversations.count;i++ {
                        let conversation = conversations[i] as NSDictionary
                        var id = conversation.objectForKey("id") as! Int
                        var name = conversation.objectForKey("name") as! String
                        
                        arrayToReturn!.insert(name, atIndex: id-1)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: true, content: arrayToReturn)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: false, content: nil)
                    })
                }
            }
        }
    }
    
    class func getMessagesForConversation(conversationID: String, completitionClosure: (success: Bool, content: Array<String>?) -> ()) {
        var arrayToReturn: Array<String>?
        
        let url = NSURL(string: "https://kcltechchat.herokuapp.com/api/conversation/\(conversationID)/messages")
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) { (response, data, error) -> Void in
            if error == nil {
                var jsonData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                
                if jsonData != nil {
                    arrayToReturn = Array<String>()
                    let messages = jsonData!.objectForKey("messages") as! Array<NSDictionary>
                    for var i = 0;i < messages.count;i++ {
                        let message = messages[i] as NSDictionary
                        let id = message.objectForKey("id") as! Int
                        let createdAt = message.objectForKey("createdAt") as! String
                        let text = message.objectForKey("text") as! String
                        
                        arrayToReturn!.insert(text, atIndex: 0)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: true, content: arrayToReturn)
                    })
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completitionClosure(success: false, content: nil)
                    })
                }
            }
        }
    }
}