//
//  YoutubeDataViewController.swift
//  YouTubeParse
//
//  Created by George Lo on 2/20/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit

class YoutubeDataViewController: UITableViewController {
    
    var imageURLArray: [String] = []
    var videoTitlesArray: [String] = []
    var videoDetailsArray: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Purdue University"
        
        let data = NSData(contentsOfURL: NSURL(string: "http://gdata.youtube.com/feeds/api/users/PurdueUniversity/uploads?alt=json")!)
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
        
        let videoListFeed = (dict["feed"] as NSDictionary)["entry"] as [NSDictionary]
        for videoEntry in videoListFeed {
            let imageURL = ((videoEntry["media$group"] as NSDictionary)["media$thumbnail"] as [NSDictionary])[0]["url"] as String!
            let title = (videoEntry["title"] as NSDictionary)["$t"] as String!
            let detail = (videoEntry["content"] as NSDictionary)["$t"] as String!
            imageURLArray.append(imageURL)
            videoTitlesArray.append(title)
            videoDetailsArray.append(detail)
        }
        
        println(imageURLArray)
        println(videoTitlesArray)
        println(videoDetailsArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return imageURLArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as UITableViewCell

        cell.imageView?.imageURL = NSURL(string: imageURLArray[indexPath.row])!
        cell.textLabel?.text = videoTitlesArray[indexPath.row]
        cell.detailTextLabel?.text = videoDetailsArray[indexPath.row]

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
