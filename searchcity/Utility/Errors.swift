//
//  Errors.swift
//  searchcity
//
//  Created by Rahul Mukherjee on 22/06/19.
//  Copyright © 2019 Rahul Mukherjee. All rights reserved.
//

import Foundation


//Define custom Error
enum FileIO: Error {
    case notFound(String)
}
