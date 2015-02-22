//
//  ViewController.swift
//  Hello World
//
//  Created by George Lo on 2/20/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var helloWorldLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloWorldLabel.font = UIFont(name: "Arial", size: 24)
        helloWorldLabel.text = "awefwaefwaf"
        
        helloWorldLabel.numberOfLines = 0
        helloWorldLabel.text = "Hello\nWorld\n!"
        helloWorldLabel.sizeToFit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

