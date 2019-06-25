//
//  APIServices.swift
//  searchcity
//
//  Created by Rahul Mukherjee on 22/06/19.
//  Copyright © 2019 Rahul Mukherjee. All rights reserved.
//

import Foundation

class APIServices {
    public static var shared = APIServices()
    
    /// Fetch all the cities from json and execute the completion block with Rows protocol Array
    public func fetchAllCities(completion: @escaping (([Row]?, Error?)->Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let cityJsonData = self.citiesData() else {
                    completion(nil,FileIO.notFound("Issue in reading File"))
                    return
                }
                let json = try decoder.decode([City].self, from: cityJsonData)
                let rows: [Row] = json
                completion(rows,nil)
            } catch let error  {
                completion(nil,error)
            }
        }
    }
    
    ///Private Function to extract data from local JSON file in Loal Bundle
    private func citiesData() -> Data? {
        if let path = Bundle.main.path(forResource: "cities", ofType: "json") {
            return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        }
        return nil
    }
}
