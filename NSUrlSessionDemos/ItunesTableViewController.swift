//
//  ItunesTableViewController.swift
//  NSUrlSessionDemos
//
//  Created by HackerU on 09/05/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation



class ItunesTableViewController: UITableViewController {

    let dataSource = ItunesDataSource()
    
    func refreshTableView(){
        dataSource.getData { (data) -> () in
            self.tableView.reloadData()
            
            for i in 0..<self.dataSource.tracks.count{
                let indexPath = NSIndexPath(forRow: i, inSection: 0)
                let track = self.dataSource.tracks[i]
                self.dataSource.downloadTrack(indexPath, track: track, resultBlock: { (indexPath) -> () in
                    self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshTableView()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
 
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.tracks.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("trackCell", forIndexPath: indexPath)

        // Configure the cell...
        let track = dataSource.tracks[indexPath.row]
        
        cell.textLabel?.text = track.artistName
        cell.detailTextLabel?.text = track.trackName
 
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let track = dataSource.tracks[indexPath.row]
        
        let fileName = NSURL(string: track.previewUrl)!.lastPathComponent!
        let fileInDiskURL = FileIO.fileUrlInDocuments(fileName)
        
        if NSFileManager.defaultManager().fileExistsAtPath(fileInDiskURL.path!) {
            let player = AVPlayer(URL: fileInDiskURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            
            presentViewController(playerViewController, animated: true, completion: { () -> Void in
                player.play()
            })
        }
        
        
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
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
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
