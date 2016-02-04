//
//  AppleApi.swift
//  NetworkingSample3
//
//  Created by Jon Thornburg on 2/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

struct AppleApi {
    
    let downloadQueue:NSOperationQueue = {
        var queue = NSOperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    func getResults(completionHandler: (resultData:NSData!, error:NSError!) -> Void) {
        print("getResults")
        
        let appleOperation = AppleApiOperation(handler: completionHandler)
        downloadQueue.addOperation(appleOperation)
    }
}