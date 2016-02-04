//
//  Result.swift
//  NetworkingSample3
//
//  Created by Jon Thornburg on 2/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import Foundation

public struct Result{
    
    var artistName: String?
    var trackName: String?
    
    public init(dictionary: [String: AnyObject]) {
        
        if let artistName = dictionary["artistName"] as? String {
            self.artistName = artistName
            
        }
        
        if let trackName = dictionary["trackName"] as? String {
            self.trackName = trackName
            
        }
        
    }
    
}
