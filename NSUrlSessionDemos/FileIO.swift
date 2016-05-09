//
//  FileIO.swift
//  NSUrlSessionDemos
//
//  Created by HackerU on 09/05/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import Foundation

class FileIO {
    
    //for example c:\documents
    static func documentsURL()->NSURL{
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    }
    
    static func copyFile(from:NSURL, to:NSURL){
        do{
            //if the dest file already exists: Delete it.
            do{
                try NSFileManager.defaultManager().removeItemAtURL(to)
            }
            catch{//file does not exist
            }
            try NSFileManager.defaultManager().copyItemAtURL(from, toURL: to)
        }
        catch let err as NSError{
            print(err)
        }
    }
    
    //for example we got fileName = 1.jpg
    //the func returns c:\documents\1.jpg
    static func fileUrlInDocuments(fileName:String)->NSURL{
        let url = documentsURL().URLByAppendingPathComponent(fileName)
        return url
    }
}
