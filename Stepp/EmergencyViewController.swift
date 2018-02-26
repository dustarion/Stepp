//
//  EmergencyViewController.swift
//  Stepp
//
//  Created by Dalton Ng on 23/2/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftySound

//CLLocationManagerDelegate, MKMapViewDelegate
class EmergencyViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    // Setting Up Mapkit
    let locationmanager = CLLocationManager()
    
    
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        mapView.mapType = MKMapType.standard
        
        let location = CLLocationCoordinate2DMake(1.336874, 103.891237)
        
        let span = MKCoordinateSpanMake(0.5, 0.5)
        let region =  MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        let annonation = MKPointAnnotation()
        annonation.coordinate = location
        annonation.title = "Fall Detected"
        annonation.subtitle = "Home"
        mapView.addAnnotation(annonation)
        
        self.locationmanager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            locationmanager.delegate = self
            locationmanager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationmanager.startUpdatingLocation()
        }
        
        mapView.isUserInteractionEnabled = false
        mapView.isScrollEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.centerMapOnLocation(location: self.homeLocation)
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0, execute: {
            //Activate Countdown
            
            // Begin Pulsing Halos
            let pulseEffect = LFTPulseAnimation(repeatCount: Float.infinity, radius:400, position:self.view.center)
            self.view.layer.insertSublayer(pulseEffect, above: self.mapView.layer)
            
            Sound.stopAll()
            
            displayAlert(view: self.view)
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 18.0, execute: {
            //self.dismissEmergency()
            self.dismiss(animated: true, completion: nil)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        locationmanager.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKUserLocation) {
            return nil
        }
        
        let annotationidentifier = "Annotationidentifier"
        
        var annotationview:MKAnnotationView
        annotationview = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationidentifier)
        annotationview.canShowCallout = true
        return annotationview
    }
    
    let homeLocation = CLLocation(latitude: 1.336874, longitude: 103.891237)
    let regionRadius: CLLocationDistance = 200
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}
