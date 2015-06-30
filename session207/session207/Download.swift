//
//  Download.swift
//  session207
//
//  Created by Alex Telek on 19/01/2015.
//  Copyright (c) 2015 Alex Telek. All rights reserved.
//

import UIKit

class Download: NSObject {
    struct Links {
        static let urlString = "https://api.github.com/users/"
    }
    
    // Create a request with the url, the body of the API call if there is one,
    // Alos can be GET, POST, DELETE...
    private class func createRequest(urlString: String, body: String?, method: String) -> NSMutableURLRequest {
        let url = NSURL(string: urlString)
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = method
        if let b = body {
            request.HTTPBody = b.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        }
        return request
    }
    
    // GET - get details of a github user
    // return name and image url
    class func getDetails(username: String, completitionHandler: (name: String?, image: UIImage?, success: Bool) -> ()) {
        let urlString = "\(Links.urlString)\(username)"
        
        NSURLConnection.sendAsynchronousRequest(createRequest(urlString, body: nil, method: "GET"), queue: NSOperationQueue()) { (response, data, error) -> Void in
            if error == nil && data != nil {
                let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? NSDictionary
                
                let name = jsonData?.objectForKey("name") as! String
                let imageURL = jsonData?.objectForKey("avatar_url") as! String
                self.getImage(imageURL, completitionHandler: { (image, success) -> () in
                    if success {
                        
                        User.addUser(username, name: name, avatar_url: imageURL)
                        Engine.saveEntity()
                        
                        completitionHandler(name: name, image: image!, success: true)
                    } else {
                        completitionHandler(name: name, image: nil, success: false)
                    }
                })
                
            } else {
                completitionHandler(name: nil, image: nil, success: false)
            }
        }
    }
    
    class func getImage(urlString: String, completitionHandler: (image: UIImage?, success: Bool) -> ()) {
        // Download an NSData representation of the image at the URL
        NSURLConnection.sendAsynchronousRequest(createRequest(urlString, body: nil, method: "GET"), queue: NSOperationQueue(), completionHandler: {(response, data, error) -> Void in
            if error == nil && data != nil {
                completitionHandler(image: UIImage(data: data), success: true)
            }
            else {
                completitionHandler(image: nil, success: false)
            }
        })
    }
}
