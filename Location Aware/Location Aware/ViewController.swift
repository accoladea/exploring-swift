//
//  ViewController.swift
//  Location Aware
//
//  Created by Zhan Dov on 12/27/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        var latitude: CLLocationDegrees = 0.0
        var longitude: CLLocationDegrees = 0.0
        
        let location = locations[0]
        
        self.latitudeLabel.text = String(location.coordinate.latitude)
        latitude = location.coordinate.latitude
        
        self.longitudeLabel.text = String(location.coordinate.longitude)
        longitude = location.coordinate.longitude
        
        
        
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let location1: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location1, span: span)
        map.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        
        annotation.title = "Current Location"
        
        annotation.subtitle = "Be aware"
        
        annotation.coordinate = location1
        
        map.addAnnotation(annotation)
        
        self.courseLabel.text = String(location.course)
        self.speedLabel.text = String(location.speed)
        self.altitudeLabel.text = String(location.altitude)
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
            
            if error != nil {
                print(error!)
            } else {
                
                if let placemark = placemarks?[0] {
                    
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "
                        
                    }
                    
                    if placemark.thoroughfare != nil {
                        
                        address += placemark.thoroughfare! + "\n"
                        
                    }
                    
                    if placemark.subLocality != nil {
                        
                        address += placemark.subLocality! + "\n"
                        
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        address += placemark.subAdministrativeArea! + "\n"
                        
                    }
                    
                    if placemark.postalCode != nil {
                        
                        address += placemark.postalCode! + "\n"
                        
                    }
                    
                    if placemark.country != nil {
                        
                        address += placemark.country! + "\n"
                        
                    }
                    
                    self.addressLabel.text = address
                    
                }
            }
            
        }
        
    }

    var manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        // creates a map
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

