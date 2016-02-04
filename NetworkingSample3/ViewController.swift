//
//  ViewController.swift
//  NetworkingSample3
//
//  Created by Jon Thornburg on 2/4/16.
//  Copyright © 2016 Jon Thornburg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var results = [Result]()
    static let resultCell = "resultCell"
    let appleApi = AppleApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadApiData()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ViewController.resultCell)
    }
    
    func loadApiData() {
        
        appleApi.getResults({ (data, error) -> Void in
            
            if let apiError = error {
                print("error \(apiError)")
                if error.code == -999 { return }
                
            } else if let resData = data {
                
                if let dictionary = HttpWrapperImpl.parseJSON(resData) {
                    
                    if let resultSet = dictionary["results"] as? [[String: AnyObject]] {
                        
                        for item in resultSet {
                            let parsedItem = Result(dictionary: item)
                            self.results.append(parsedItem)
                        }
                        self.tableView.reloadData()
                        print("results \(self.results)")
                        
                    } else {
                        print("error no results")
                    }
                }
                
            }
            
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ViewController.resultCell, forIndexPath: indexPath)
        let searchResult = self.results[indexPath.row]
        
        if let artist = searchResult.artistName {
            cell.textLabel?.text = artist
        }
        return cell
    }
}

