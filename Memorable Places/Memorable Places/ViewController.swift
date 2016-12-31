//
//  ViewController.swift
//  Memorable Places
//
//  Created by Zhan Dov on 12/29/16.
//  Copyright © 2016 Accolade. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(gestureRecognizer:)))
        
        uilpgr.minimumPressDuration = 2
        
        map.addGestureRecognizer(uilpgr)
        
        if activePlace != -1 {
            // Get place details to display on map
            
            if places.count > activePlace {
                
                if let name =  places[activePlace]["name"] {
                    if let lat = places[activePlace]["lat"] {
                        if let lon = places[activePlace]["lon"] {
                            if let latitude = Double(lat){
                                if let  longitude = Double(lon) {
                                    let span = MKCoordinateSpanMake(0.05, 0.05)
                                    
                                    let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
                                    let region = MKCoordinateRegion(center: coordinate, span: span)
                                    
                                    self.map.setRegion(region, animated: true)
                                    
                                    let annotation = MKPointAnnotation()
                                    annotation.coordinate = coordinate
                                    annotation.title = name
                                    self.map.addAnnotation(annotation)
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }

    func longpress(gestureRecognizer: UIGestureRecognizer){
    
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = gestureRecognizer.location(in: self.map)
        
            let newCoordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
        
            let location = CLLocation(latitude: newCoordinate.latitude,longitude: newCoordinate.longitude)
            
            var title = ""
            
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
                if error != nil {
                    
                    print(error)
                } else {
                    
                    if let placemark = placemarks?[0] {
                        if placemark.subThoroughfare != nil {
                            title += placemark.subThoroughfare! + " "
                        }
                        
                        if placemark.thoroughfare != nil {
                            title += placemark.thoroughfare!
                        }
                    }
                }
                
                if title == "" {
                    title = "Added \(NSDate())"
                }
            })
            
        
            let annotation = MKPointAnnotation ()
        
            annotation.coordinate = newCoordinate
        
            annotation.title = title
        
            self.map.addAnnotation(annotation)
            places.append(["name":title, "lat":String(newCoordinate.latitude), "lon":String(newCoordinate.longitude)])
            
            print(places)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

