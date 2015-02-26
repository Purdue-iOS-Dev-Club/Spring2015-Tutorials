//
//  ViewController.swift
//  WKWebViewTutorial
//
//  Created by George Lo on 2/25/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let webView = WKWebView(frame: CGRectMake(0, 0, 320, 568))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.loadRequest(NSURLRequest(URL: NSURL(string: "http://www.yahoo.com/")!))
        self.view.addSubview(webView)
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "printTitle", userInfo: nil, repeats: true)
    }
    
    func printTitle() {
        println(webView.title)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

