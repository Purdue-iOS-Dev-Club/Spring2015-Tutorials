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
    var operatorChar: String = ""
    var currentNum: Int = 0
    var previousNum: Int = 0
    
    @IBAction func appendDigit(sender: UIButton) {
        currentNum = currentNum * 10 + sender.titleLabel!.text!.toInt()!
        digitsText += sender.titleLabel!.text!
        digitLabel.text = digitsText
    }
    
    @IBAction func operatorPressed(sender: UIButton) {
        operatorChar = sender.titleLabel!.text!
        previousNum = currentNum
        currentNum = 0
        digitsText = ""
    }
    
    @IBAction func equalPressed(sender: UIButton) {
        println(previousNum)
        println(currentNum)
        if operatorChar == "+" {
            digitsText = "\(previousNum + currentNum)"
        } else if operatorChar == "-" {
            digitsText = "\(previousNum - currentNum)"
        } else if operatorChar == "X" {
            digitsText = "\(previousNum * currentNum)"
        } else if operatorChar == "/" {
            digitsText = "\(previousNum / currentNum)"
        }
        
        println(digitsText)
        
        currentNum = 0
        
        digitLabel.text = digitsText
    }
    
    @IBAction func clear(sender: UIButton) {
        digitsText = ""
        operatorChar = ""
        currentNum = 0
        previousNum = 0
        digitLabel.text = "0"
    }
    
    @IBAction func del(sender: UIButton) {
        digitsText = digitsText.substringToIndex(advance(digitsText.startIndex, digitsText.utf16Count - 1))
        digitLabel.text = digitsText
    }
    
    func updateUI() {
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

