//
//  Models.swift
//  searchcity
//
//  Created by Rahul Mukherjee on 22/06/19.
//  Copyright © 2019 Rahul Mukherjee. All rights reserved.
//

import Foundation

protocol Row {
    
}

struct City: Codable, Row {
    var _id: Int
    var country: String
    var name: String
    var coord: coord
}

struct coord: Codable {
    var lat: Float
    var lon: Float
    var distanceFromUser: Float?
}
