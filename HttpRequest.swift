//
//  HttpRequest.swift
//  NetworkingSample3
//
//  Created by Jon Thornburg on 2/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

public struct HttpRequest{
    
    /**
     Handle an NSURLRequest with GET
     - Returns An NSURLRequest, add any headers or additional data here
     */
    
    static func createRequest(urlString: String) -> NSURLRequest {
        let url: NSURL = NSURL(string: urlString)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL:url)
        request.HTTPMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
}