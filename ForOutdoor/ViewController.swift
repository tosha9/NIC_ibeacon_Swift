//
//  ViewController.swift
//  ForOutdoor
//
//  Created by Tosha on 4/10/15.
//  Copyright (c) 2015 NICUSA. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "Estimotes")
    
    
    @IBOutlet weak var beaconLabel: UILabel!
    
    
    
    // Note: make sure you replace the keys here with your own beacons' Minor Values
    let colors = [
        8677: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1), // Dark blue
        9738: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1), // Light blue
        59272: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)//Mint
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func locationManager(manager: CLLocationManager!,
        didEnterRegion region: CLRegion!) {
            manager.startRangingBeaconsInRegion(region as! CLBeaconRegion)
            manager.startUpdatingLocation()
            
            NSLog("You entered the region")
        //    sendLocalNotificationWithMessage("You entered the region")
    }
    
    func locationManager(manager: CLLocationManager!,
        didExitRegion region: CLRegion!) {
            manager.stopRangingBeaconsInRegion(region as! CLBeaconRegion)
            manager.stopUpdatingLocation()
            
            NSLog("You exited the region")
           // sendLocalNotificationWithMessage("You exited the region")
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
        println(knownBeacons.count)
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as! CLBeacon
            self.view.backgroundColor = self.colors[closestBeacon.minor.integerValue]
            
            switch closestBeacon.minor.integerValue
            {
                case 9738:
                beaconLabel.text = "Hey the water is in proximity"
                
            case 8677:
                beaconLabel.text = "Keep hiking almost there"
                
            case 59272:
                beaconLabel.text = "The restroom is nearby"
                
            default:
                beaconLabel.text = "Nothing to display"
                
            }
            
        
        
        }
    }
}




