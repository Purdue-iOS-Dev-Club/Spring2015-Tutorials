//
//  ViewController.swift
//  Calculator
//
//  Created by George Lo on 1/28/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var digitLabel: UILabel!
    
    var digitsText: String = ""
    
    @IBAction func appendDigit(sender: UIButton) {
        if digitsText == "0" {
            digitsText = ""
        }
        digitsText += sender.titleLabel!.text!
        updateUI()
    }
    
    @IBAction func clear(sender: UIButton) {
        digitsText = ""
        updateUI()
    }
    
    @IBAction func del(sender: UIButton) {
        digitsText = digitsText.substringToIndex(advance(digitsText.startIndex, digitsText.utf16Count - 1))
        updateUI()
    }
    
    func updateUI() {
        if digitsText == "" {
            digitsText = "0"
        }
        digitLabel.text = digitsText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

