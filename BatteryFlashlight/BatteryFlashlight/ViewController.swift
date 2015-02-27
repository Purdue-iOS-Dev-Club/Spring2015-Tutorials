//
//  ViewController.swift
//  BatteryFlashlight
//
//  Created by George Lo on 2/27/15.
//  Copyright (c) 2015 Purdue iOS Dev Club. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.currentDevice().batteryMonitoringEnabled = true
        
        switch UIDevice.currentDevice().batteryState {
        case UIDeviceBatteryState.Full:
            println("Full")
            break;
        default:
            break;
            // ... so on
        }
        
        println("Battery Level: \(UIDevice.currentDevice().batteryLevel * 100)%")
        
        let devices = AVCaptureDevice.devices() as [AVCaptureDevice]
        for p: AVCaptureDevice in devices {
            p.lockForConfiguration(nil)
            if p.hasTorch {
                p.torchMode = AVCaptureTorchMode.On
            }
        }
        
        let session = AVAudioSession.sharedInstance()
        session.requestRecordPermission({(granted: Bool) -> Void in
            if granted == true {
                let recorder = AVAudioRecorder()
                recorder.record()
                
                // recorder.play()
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

