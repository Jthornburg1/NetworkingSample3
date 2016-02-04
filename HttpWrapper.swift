//
//  HttpWrapper.swift
//  NetworkingSample3
//
//  Created by Jon Thornburg on 2/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

protocol HttpWrapper {
    static func sendRequest(request: NSURLRequest, completion:(NSData!, NSError!) -> Void) -> ()
}

public class HttpWrapperImpl: HttpWrapper{
    
    /**
     
     Handle an NSURLRequest
     
     - Parameter request: Pass in an NSURLRequest.
     - Parameter completion: Completion handler that will pass back data and error tuple
     
     */
    
    public class func sendRequest(request: NSURLRequest, completion:(NSData!, NSError!) -> Void) -> () {
        
        // Create a NSURLSession task.  This object handles multithreading to support
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request) { (data: NSData?,  response: NSURLResponse?, error: NSError?) in
            
            //If error returned from NSURLSession, notify UI passing back the error object
            if error != nil {
                //In order to notify UI objects, the completion block needs to fire on the main thread.  NSURLSession runs on a worker thread
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print("sendRequest error")
                    completion(data, error)
                })
                
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                
                //In order to notify UI objects, the completion block needs to fire on the main thread.  NSURLSession runs on a worker thread
                if let httpResponse = response as? NSHTTPURLResponse {
                    if httpResponse.statusCode == 200 || httpResponse.statusCode == 201 {
                        completion(data, nil)
                    } else {
                        
                        //Notify UI with error if response does not return proper HTTP code
                        let responseError : NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: nil)
                        completion(data, responseError)
                    }
                }
            })
        }
        
        // start the task
        task.resume()
    }
    
    public class func parseJSON(data: NSData) -> [String: AnyObject]? {
        
        do {
            // Try parsing some valid JSON
            let json = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions(rawValue: 0)) as? [String: AnyObject]
            return json
        }
        catch let error as NSError {
            // Catch fires here, with an NSError being thrown from the JSONObjectWithData method
            print("A JSON parsing error occurred, here are the details:\n \(error)")
        }
        
        return nil
    }

}

