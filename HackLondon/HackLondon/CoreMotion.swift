//
//  CoreMotion.swift
//  HackLondon
//
//  Created by Alex Telek on 27/02/2015.
//  Copyright (c) 2015 KCLTech. All rights reserved.
//

import UIKit
import CoreMotion

class CoreMotion: UIViewController {

    var stepManager: CMPedometer?
    var motionManager: CMMotionManager?
    
    @IBOutlet weak var lblSteps: UILabel!
    @IBOutlet weak var lblAcc: UILabel!
    @IBOutlet weak var lblGyro: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        stepManager = CMPedometer()
    
        if CMPedometer.isStepCountingAvailable() {
            stepManager?.startPedometerUpdatesFromDate(NSDate(), withHandler: { (data: CMPedometerData!, error) -> Void in
                if error == nil {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.lblSteps.text = "\(data.numberOfSteps)"
                    })
                }
            })
        }
        
        motionManager = CMMotionManager()
        motionManager?.accelerometerUpdateInterval = 0.2;
        motionManager?.gyroUpdateInterval = 0.2;
        
        motionManager?.startAccelerometerUpdatesToQueue(NSOperationQueue(), withHandler: { (data, error) -> Void in
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.lblAcc.text = "X: \(data.acceleration.x)\n Y: \(data.acceleration.y)\n Z: \(data.acceleration.z)"
                })
            }
        })
        
        motionManager?.startGyroUpdatesToQueue(NSOperationQueue(), withHandler: { (data, error) -> Void in
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.lblGyro.text = "X: \(data.rotationRate.x)\n Y: \(data.rotationRate.y)\n Z: \(data.rotationRate.z)"
                })
            }
        })
    }
}
