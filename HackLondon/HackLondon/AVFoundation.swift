//
//  ViewController.swift
//  HackLondon
//
//  Created by Alex Telek on 26/02/2015.
//  Copyright (c) 2015 KCLTech. All rights reserved.
//

import UIKit
import AVFoundation

class AVFoundation: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidAppear(animated: Bool) {
        if imageView.image == nil {
            var picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .Camera
            picker.allowsEditing = true
            picker.showsCameraControls = true
            
            self.presentViewController(picker, animated: true, completion: nil)
        }
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        imageView.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let share = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        self.presentViewController(share, animated: true, completion: nil)
    }
}

