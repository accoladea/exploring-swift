//
//  ViewController.swift
//  Maps
//
//  Created by Zhan Dov on 12/27/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

//map.setRegion(MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: 24.416835, longitude: 54.474021), MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)), animated: true)
////////////////////////////////////////////////////////////////////////////////////////
//        let location = CLLocationCoordinate2D(latitude: 24.416835, longitude: 54.474021)
//        
//        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
//        
//        let region = MKCoordinateRegion(center: location, span: span)
//        
//        map.setRegion(region, animated: true)
////////////////////////////////////////////////////////////////////////////////////////

        let latitude: CLLocationDegrees = 24.416835
        let longitude: CLLocationDegrees = 54.474021
        
        let latDelta: CLLocationDegrees = 0.05
        let lonDelta: CLLocationDegrees = 0.05
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.title = "Taj Mahal"
        
        annotation.subtitle = "One day I'll go here"
        
        annotation.coordinate = location
        
        map.addAnnotation(annotation)
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func longpress(gestureRecognizer: UIGestureRecognizer){
        
        let touchPoint = gestureRecognizer.location(in: self.map)
        
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = coordinate
        annotation.title = "New Place"
        annotation.subtitle = "Maybe I'll go here too..."
        map.addAnnotation(annotation)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

