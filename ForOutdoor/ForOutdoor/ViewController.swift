//
//  ViewController.swift
//  ForOutdoor
//
//  Created by Tosha on 4/10/15.
//  Copyright (c) 2015 NICUSA. All rights reserved.
//

import UIKit
import CoreLocation

import TwitterKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let region = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "Estimotes")
    
    
    @IBOutlet weak var beaconLabel: UILabel!
    
    @IBOutlet weak var beaconLabel1: UILabel!
    
    
    @IBOutlet weak var beaconLabel2: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    // Note: make sure you replace the keys here with your own beacons' Minor Values
    let colors = [
        8677: UIColor(red: 84/255, green: 77/255, blue: 160/255, alpha: 1), // Dark blue
        9738: UIColor(red: 142/255, green: 212/255, blue: 220/255, alpha: 1), // Light blue
        59272: UIColor(red: 162/255, green: 213/255, blue: 181/255, alpha: 1)//Mint
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* let logInButton = TWTRLogInButton(logInCompletion: {
            (session: TWTRSession!, error: NSError!) in
            // play with Twitter session
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)*/

        
        
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
            
            // beaconLabel.text = "  Hello"
            
            switch closestBeacon.minor.integerValue
            {
                case 9738:
                beaconLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
                beaconLabel.text = "This is example of park check in."
                
                beaconLabel1.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
                beaconLabel1.text = "Welcome to Cedar Creek & Belle Grove National Historical Park "
               

                
                myImage.image = UIImage(named: "park.jpg")
                
                 beaconLabel2.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
                 beaconLabel2.text = "The mission at Annmarie Garden is to provide a place to commune with nature through the creation and maintenance of public thematic outdoor garden rooms developed by artists and landscape architects."
                
               

                
            case 8677:
                beaconLabel.textColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
                beaconLabel.text = "This is a self guided Tour demo"
                
                beaconLabel1.textColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
                beaconLabel1.text = "Following arifact has been 1000 years old"
                
                myImage.image = UIImage(named: "artifact.jpg")

                beaconLabel2.textColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
                beaconLabel2.text = "Move on to right to explore more. BTW if you are hungry there are DC Sclices have yummy pizza there."
                
                
                
            case 59272:
                beaconLabel.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
                beaconLabel.text = "This is no cellphone zone"
                
                beaconLabel1.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
                beaconLabel1.text = "Good news ibeacon works here!"
                
                beaconLabel2.textColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
                beaconLabel2.text = "Keep hiking you are almost there/ Fill up water no station till a mile/Restroom nearby"
                
                
                myImage.image = UIImage(named: "yourhere.jpg")

                
            default:
                beaconLabel.text = "Hey you are not near park"
                beaconLabel1.text = "Plz do visit"
                
                 beaconLabel2.text = "Its fun and mostly free"
                
            }
            
        
        
        }
    }
}




