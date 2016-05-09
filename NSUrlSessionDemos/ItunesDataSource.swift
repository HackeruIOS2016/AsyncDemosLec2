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
