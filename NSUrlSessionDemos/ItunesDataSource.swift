//
//  ItunesDataSource.swift
//  NSUrlSessionDemos
//
//  Created by HackerU on 09/05/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import UIKit

class ItunesDataSource{
    
    var tracks = [ItunesTrack]()
    
    let url = NSURL(string:"https://itunes.apple.com/search?media=music&entity=song&term=swift")!
    
    let session = NSURLSession.sharedSession()
    
//    func downloadTrack(indexPath:NSIndexPath, track:ItunesTrack){
//        //1) url for the track
//        let url = NSURL(string: track.previewUrl)!
//        
//        //task for the track
//        let task = session.downloadTaskWithURL(url) { (fileURL, response, error) -> Void in
//            
//            guard let fileURL = fileURL else{return}
//            
//            let destURL = FileIO.fileUrlInDocuments(url.lastPathComponent!)
//            FileIO.copyFile(fileURL, to: destURL)
//            
//            
//        }
//        //resume the suspended task
//        task.resume()
//    }
    
    
    
    
    
    func downloadTrack(indexPath:NSIndexPath, track:ItunesTrack, resultBlock:(NSIndexPath)->()){
        let itunesPreviewUrl = NSURL(string: track.previewUrl)!
        
        let task = session.downloadTaskWithURL(itunesPreviewUrl) { (dlFileURL, response, error) -> Void in
            
            //handle errors:
            guard let dlFileURL = dlFileURL else{return}
            
            //the name of the original file from the url
            let originalFileName:String = itunesPreviewUrl.lastPathComponent!
            
            //c:\documents\originalFileName.jpg
            let destURL = FileIO.fileUrlInDocuments(originalFileName)
            
            //copy the file
            FileIO.copyFile(dlFileURL, to: destURL)
            
            let image = UIImage(contentsOfFile: destURL.path ?? "")
            
            
            dispatch_async(Queues.main){resultBlock(indexPath)}
            
        }
        //resume the suspended task
        task.resume()
    }
    
    
    
    
    
    
    func getData(resultBlock: ([ItunesTrack])->()){
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            //test for nil, if nil exit
            guard let data = data else {return}
            
            //try to parse the json
            let json =  try?  NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            
            //use the json to retrieve the data
            guard let arr = json?["results"] as? NSArray else{return}
            
            var tunes = [ItunesTrack]()
            
            for item in arr{
                let previewUrl = item["previewUrl"] as! String
                let trackName = item["trackName"] as! String
                let artistName = item["artistName"] as! String
                
                let track = ItunesTrack(previewUrl: previewUrl, trackName: trackName, artistName: artistName)
                
                tunes.append(track)
            }
            //return the data using the delegate block
            dispatch_async(Queues.main, { () -> Void in
                self.tracks = tunes
                resultBlock(self.tracks)
            })
        }
        task.resume()
    }
}
