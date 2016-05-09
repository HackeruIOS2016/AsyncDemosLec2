//
//  ItuensTrack.swift
//  NSUrlSessionDemos
//
//  Created by HackerU on 09/05/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//


class ItunesTrack: CustomStringConvertible{
    var previewUrl:String
    var trackName:String
    var artistName:String
    
    init(previewUrl:String, trackName:String, artistName:String){
        self.previewUrl = previewUrl
        self.trackName = trackName
        self.artistName = artistName
    }
    
    var description:String{
        return "\(artistName) - \(trackName)"
    }
}
