//
//  RedditDataSource.swift
//  NSUrlSessionDemos
//
//  Created by HackerU on 09/05/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import UIKit
//"https://itunes.apple.com/search?media=music&entity=song&term=\(searchTerm)")
class RedditDataSource{
    
    let url = NSURL(string:"https://www.reddit.com/.json")!
    let session = NSURLSession.sharedSession()
    
    
    func getData(resultBlock: ([Reddit])->()){
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            guard let data = data else {return}
            
            let json =  try?  NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            guard let arr = json?["data"]??["children"] as? NSArray else{return}
        
            var reddits = [Reddit]()
            
            for item in arr{
                let reddit = item["data"]!!
                let title = reddit["title"] as! String
                let thumbnail = reddit["thumbnail"] as! String
                let url = reddit["url"] as! String
                
                let r = Reddit(title: title, thumbnail: thumbnail, url: url)
 
                reddits.append(r)
            }
            //return the data using the delegate block
            dispatch_async(Queues.main, { () -> Void in
                resultBlock(reddits)
            })
            
        }
        
        task.resume()
    }
}
