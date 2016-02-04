//
//  ViewController.swift
//  NetworkingSample3
//
//  Created by Jon Thornburg on 2/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let request = HttpRequest.createRequest("https://itunes.apple.com/search?term=bb+king&limit=20")
        
        HttpWrapperImpl.sendRequest(request, completion: {(data:NSData!, error:NSError!) in
            // Display error
            
            if let apiError = error {
                print("error \(apiError)")
                if error.code == -999 { return }
                
            } else if let resData = data {
                if let dictionary = HttpWrapperImpl.parseJSON(resData) {
                    print("dictionary \(dictionary)")
                }
                
            }
            
            
        })

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

