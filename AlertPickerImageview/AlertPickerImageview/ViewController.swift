//
//  ViewController.swift
//  AlertPickerImageview
//
//  Created by George Lo on 2/27/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit
//import QuartzCore

class ViewController: UIViewController, UIAlertViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let continent = ["Asia", "Africa", "North America", "Europe", "South America", "Australia"]
    let cities = ["West Lafayette", "New York", "Beijing", "Taipei", "Tokyo", "San Fran"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username = NSUserDefaults.standardUserDefaults().objectForKey("Username") as String
        let password = NSUserDefaults.standardUserDefaults().objectForKey("Password") as String
        
        // Get request
        /*let urlString = "https://www.facebook.com/login?"
        let loginInfo = "username=\(username)&password=\(password)"
        let completeString = urlString + loginInfo
        let responseData = NSURLConnection.sendSynchronousRequest(completeString, returningResponse: nil, error: nil)
        let responseString = NSString(data: responseData, encoding: NSASCIIStringEncoding)
        if responseString == "User is valid" {
        }*/
        
        
        let pickerView = UIPickerView(frame: CGRectMake(0, 280, self.view.frame.width, self.view.frame.height - 280))
        pickerView.dataSource = self
        pickerView.delegate = self
        self.view.addSubview(pickerView)
        
        let imageView = UIImageView(frame: CGRectMake(40, 20, self.view.frame.width - 80, 200))
        
        // No caching
        // imageView.image = UIImage(contentsOfFile: "wallpaper")
        
        // Cache
        imageView.image = UIImage(named: "wallpaper")
        
        // Rounded corner
        //imageView.layer.cornerRadius = 50
        //imageView.layer.masksToBounds = true
        
        imageView.layer.shadowColor = UIColor.blackColor().CGColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowOffset = CGSizeMake(1, 1)
        imageView.layer.shadowRadius = 15
        
        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(40, 240, 50, 30)
        button.setTitle("Press", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
        
        
        self.view.addSubview(imageView)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return continent.count
        }
        return cities.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if component == 0 {
            return continent[row]
        }
        return cities[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            println("User selected: " + continent[row])
        } else if component == 1 {
            println("User selected: " + cities[row])
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.buttonTitleAtIndex(buttonIndex) != "Cancel" {
            let username = alertView.textFieldAtIndex(0)?.text
            let password = alertView.textFieldAtIndex(1)?.text
            println(username)
            println(password)
            
            NSUserDefaults.standardUserDefaults().setObject(username, forKey: "Username")
            NSUserDefaults.standardUserDefaults().setObject(password, forKey: "Password")
            
                NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func buttonPressed() {
        let alertView = UIAlertView(title: "Sign In", message: "Please enter your username and password", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "OK")
        alertView.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
        alertView.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

