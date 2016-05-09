//
//  ViewController.swift
//  NSUrlSessionDemos
//
//  Created by HackerU on 09/05/2016.
//  Copyright © 2016 HackerU. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let dataSource = ItunesDataSource()
        
        dataSource.getData { (tunes) -> () in
            //print(tunes)
            
            for tune in tunes{
                print(tune)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

