//
//  AVFoundation.swift
//  HackLondon
//
//  Created by Alex Telek on 26/02/2015.
//  Copyright (c) 2015 KCLTech. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class Presentation: UIViewController {
    
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    // If we find a device we'll store it here for later use
    var captureDevice : AVCaptureDevice?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        captureSession.sessionPreset = AVCaptureSessionPreset1920x1080
        
        let devices = AVCaptureDevice.devices()
        
        // Loop through all the capture devices on this phone
        for device in devices {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        println("Capture device found")
                        
                        device.unlockForConfiguration()
                        
                        beginSession()
                    }
                }
            }
        }
        
    }
    
    func focusTo(value : Float) {
        if let device = captureDevice {
            if(device.lockForConfiguration(nil)) {
                device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
                    //
                })
                device.unlockForConfiguration()
            }
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        var anyTouch = touches.first as! UITouch
        var touchPercent = anyTouch.locationInView(self.view).x / UIScreen.mainScreen().bounds.size.width
        if let device = captureDevice {
            if(device.lockForConfiguration(nil)) {
                device.focusMode = AVCaptureFocusMode.AutoFocus
                device.unlockForConfiguration()
            }
        }
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        var anyTouch = touches.first as! UITouch
        var touchPercent = anyTouch.locationInView(self.view).x / UIScreen.mainScreen().bounds.size.width
        focusTo(Float(touchPercent))
    }
    
    func configureDevice() {
        if let device = captureDevice {
            device.lockForConfiguration(nil)
            device.focusMode = .Locked
            device.unlockForConfiguration()
        }
        
    }
    
    func beginSession() {
        
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
    
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
        previewLayer?.frame = self.view.bounds
        previewLayer!.connection.videoOrientation = videoOrientationFromCurrentDeviceOrientation()
        self.view.layer.addSublayer(previewLayer)
        captureSession.startRunning()
    }
 
    func videoOrientationFromCurrentDeviceOrientation() -> AVCaptureVideoOrientation {
        switch self.interfaceOrientation {
        case .Portrait:
            return AVCaptureVideoOrientation.Portrait;
        case .LandscapeLeft:
            return AVCaptureVideoOrientation.LandscapeRight;
        case .LandscapeRight:
            return AVCaptureVideoOrientation.LandscapeLeft;
        case .PortraitUpsideDown:
            return AVCaptureVideoOrientation.PortraitUpsideDown;
        default: return AVCaptureVideoOrientation.Portrait
            }
    }
    
}