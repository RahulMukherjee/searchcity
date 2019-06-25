//
//  CityCellViewModel.swift
//  searchcity
//
//  Created by Rahul Mukherjee on 24/06/19.
//  Copyright © 2019 Rahul Mukherjee. All rights reserved.
//

import Foundation
import CoreLocation

class CityCellViewModel {
    private var city: City
    
    init(city: City) {
        self.city = city
    }
    
    ///city, country text
    public var cityCountry: String {
        return "\(city.name), \(city.country)"
    }
    
    ///Calclulate distance from user current location
    public var distance: String {
        if let myLocationCoordinate = userCurrentLocation() {
            let myLocation = CLLocation(latitude: myLocationCoordinate.latitude, longitude: myLocationCoordinate.longitude)
            let cityLocation = CLLocation(latitude: CLLocationDegrees(city.coord.lat), longitude: CLLocationDegrees(city.coord.lon))
            let distanceFromUser = myLocation.distance(from: cityLocation) / 1000
            return String(format: " %.02f km", distanceFromUser)
        }
        return ""
    }
    
}
