//
//  ViewController.swift
//  CSVProject
//
//  Created by George Lo on 1/24/15.
//  Copyright (c) 2015 Purdue iOS Club. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let csvArray = NSArray(
        contentsOfCSVURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("School", ofType: "csv")!),
        options: CHCSVParserOptions.SanitizesFields
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(csvArray)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Decrement one to ignore the header row
        return csvArray.count - 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        if let collegeInfo = csvArray[indexPath.row + 1] as? [String] {
            cell.textLabel?.text = collegeInfo[0] // Name
            cell.detailTextLabel?.text = collegeInfo[2] // Location
        }
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

