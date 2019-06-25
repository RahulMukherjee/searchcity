//
//  Utility.swift
//  searchcity
//
//  Created by Rahul Mukherjee on 24/06/19.
//  Copyright © 2019 Rahul Mukherjee. All rights reserved.
//

import Foundation
import CoreLocation

///Fetch user current location if permited
func userCurrentLocation()-> CLLocationCoordinate2D? {
    let locManager = CLLocationManager()
    if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() ==  .authorizedAlways) {
        return locManager.location?.coordinate
    }
    return nil
}

///print the debug log
func appLog(_ text: String) {
    print(text)
}
