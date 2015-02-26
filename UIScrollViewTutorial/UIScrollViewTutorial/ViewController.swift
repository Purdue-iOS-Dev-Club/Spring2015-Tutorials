//
//  ViewController.swift
//  UIScrollViewTutorial
//
//  Created by George Lo on 2/25/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        let block = UIView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height * 2 / 3))
        block.backgroundColor = UIColor.blueColor()
        let block2 = UIView(frame: CGRectMake(0, self.view.frame.height * 2 / 3, self.view.frame.width, self.view.frame.height * 2 / 3))
        block2.backgroundColor = UIColor.redColor()
        
        scrollView.contentSize = CGSizeMake(self.view.frame.height, block.frame.height + block2.frame.height)
        
        scrollView.addSubview(block)
        scrollView.addSubview(block2)
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

