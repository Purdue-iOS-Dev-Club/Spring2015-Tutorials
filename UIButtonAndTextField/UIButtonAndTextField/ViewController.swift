//
//  ViewController.swift
//  UIButtonAndTextField
//
//  Created by George Lo on 2/27/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myButton.setTitle("Press", forState: UIControlState.Normal)
        myButton.setTitle("Pressed", forState: UIControlState.Selected)
        myButton.setTitle("Highlighted", forState: UIControlState.Highlighted)
        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone {
            myTextField.keyboardType = UIKeyboardType.PhonePad
        }
        myTextField.returnKeyType = UIReturnKeyType.Done
        myTextField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

