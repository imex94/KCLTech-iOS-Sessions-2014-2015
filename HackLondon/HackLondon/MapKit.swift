//
//  MapKit.swift
//  HackLondon
//
//  Created by Alex Telek on 27/02/2015.
//  Copyright (c) 2015 KCLTech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapKit: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // locationManager setup
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
        
        
        // long press gesture for dropping a pin
        let longGesture = UILongPressGestureRecognizer()
        longGesture.addTarget(self, action: Selector("dropPin:"))
        longGesture.minimumPressDuration = 1.2
        mapView.addGestureRecognizer(longGesture)
        
    }
    
    //MARK: CLLocationManager delegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        locationManager?.stopUpdatingLocation()
        let currentLocation = locations.first as! CLLocation
        
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    func dropPin(gesture: UILongPressGestureRecognizer) {
        let touch = gesture.locationInView(mapView)
        let touchCoordinate = mapView.convertPoint(touch, toCoordinateFromView: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchCoordinate
        annotation.title = "HackLondon"
        annotation.subtitle = "WC2R 2LS"
        mapView.addAnnotation(annotation)
    }
}
