//
//  AppleApiOperation.swift
//  NetworkingSample3
//
//  Created by Jon Thornburg on 2/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

class AppleApiOperation: NSOperation {
    private let handler: (resultData:NSData!, error: NSError!) -> Void
    
    init(handler: (resultData:NSData!, error: NSError!) -> Void) {
        self.handler = handler
    }
    
    override func main() {
        let request = HttpRequest.createRequest("https://itunes.apple.com/search?term=bb+king&limit=20")
        
        HttpWrapperImpl.sendRequest(request, completion: {(data:NSData!, error: NSError!) in
            self.handler(resultData: data, error: error)
        })
    }
}
