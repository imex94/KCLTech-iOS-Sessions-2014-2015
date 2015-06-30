//
//  CoreBluetooth.swift
//  HackLondon
//
//  Created by Alex Telek on 27/02/2015.
//  Copyright (c) 2015 KCLTech. All rights reserved.
//

import UIKit
import CoreBluetooth

class CoreBluetooth: UIViewController, CBCentralManagerDelegate {

    var bluetoothManager: CBCentralManager!
    
    @IBOutlet weak var txtBluetooth: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        bluetoothManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        
        var state = "Unknown"
        switch peripheral.state {
            case .Connected: state = "Connected"
            case .Disconnected: state = "Disconnected"
            case .Connecting: state = "Connecting"
        }
        
        txtBluetooth.text = txtBluetooth.text.stringByAppendingString("\(RSSI): \(peripheral.name) - \(state)\n")
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        if central.state == CBCentralManagerState.PoweredOn {
            bluetoothManager.scanForPeripheralsWithServices(nil, options: nil)
        }
    }
}
