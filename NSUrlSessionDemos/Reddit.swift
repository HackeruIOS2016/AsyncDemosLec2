//
//  Reddit.swift
//  NSUrlSessionDemos
//
//  Created by HackerU on 09/05/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import UIKit

class Reddit: CustomStringConvertible{
    var title:String
    var thumbnail:String
    var url:String
    
    init(title:String, thumbnail:String, url:String){
        self.thumbnail = thumbnail
        self.title = title
        self.url = url
    }
    
    var description:String{
        return title
    }
}
