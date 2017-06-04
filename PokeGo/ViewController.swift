//
//  ViewController.swift
//  PokeGo
//
//  Created by admin on 02/06/2017.
//  Copyright © 2017 Alex Keaveney. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    
    var manager = CLLocationManager()
    
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        //sets view controller as a CLLocationManager
        manager.delegate = self
        
        //checks to see if the app is authorized to get the location
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("We are authorized")
            
            //Show the users location on the map
            map.showsUserLocation = true
            
            //track the users location
            manager.startUpdatingLocation()
            
            //timer to spawn a pokemon every 5 seconds
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                
                
                
                
                if let coord = self.manager.location?.coordinate {
                    let anno = MKPointAnnotation()
                    anno.coordinate = coord
                    anno.coordinate.latitude += (Double(arc4random_uniform(200))-100.0)/50000.0
                    anno.coordinate.longitude += (Double(arc4random_uniform(200))-100.0)/50000.0
                    self.map.addAnnotation(anno)
                }
                
            })
            
        }
        else {
            //ask the user to use their location when they are using the app
            manager.requestWhenInUseAuthorization()
        }
        
        
    }
    
    //called in a loop when the location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        //first three updates to get the users location centered
        if (updateCount < 3) {
        
            //gets the users region
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
            
            //zoom in to users location
            map.setRegion(region, animated: false)
            
            updateCount += 1
        
        }
            
        //stops updating location after three
            
        else {
            manager.stopUpdatingLocation()
        
        }
    }

    //if compass is clicked center the users position
    @IBAction func centerTapped(_ sender: Any) {
        
        //gets the users region
        
        if let coord = manager.location?.coordinate {
            
            let region = MKCoordinateRegionMakeWithDistance(manager.location!.coordinate, 200, 200)
        
            //zoom in to users location
            map.setRegion(region, animated: true)
        }
    }
    


}

