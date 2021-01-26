//
//  FirstViewController.swift
//  TaskManager
//
//  Created by Rohil on 6/13/20.
//  Copyright © 2020 TM. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications

var currentLoc: CLLocation!



class ViewController: UIViewController, CLLocationManagerDelegate {
   var locationManager = CLLocationManager()
    
   override func viewDidLoad() {
      super.viewDidLoad()
    print("loaded")
    locationManager.delegate = self
    
    locationManager.requestWhenInUseAuthorization()
    //var currentLoc: CLLocation!
    if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
    CLLocationManager.authorizationStatus() == .authorizedAlways) {
       //currentLoc = locationManager.location
       print(currentLoc.coordinate.latitude)
       print(currentLoc.coordinate.longitude)
     
    } else {
        print("Forced")
    }
    
    //local notifications
    /*
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.alert, .sound], completionHandler: {(granted, error) in})
    
    let content = UNMutableNotificationContent()
    
    content.title = "Hey I'm a notification"
    content.body = "Look, i am here"
    
    let date = Date().addingTimeInterval(5)
    
    let dateComponents = Calendar.current.dateComponents([.year,.month,.day,.hour, .minute, .second], from: date)

    
   let trigger =  UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
 */
}

}
