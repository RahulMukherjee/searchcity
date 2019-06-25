//
//  CitiesViewModel.swift
//  searchcity
//
//  Created by Rahul Mukherjee on 24/06/19.
//  Copyright © 2019 Rahul Mukherjee. All rights reserved.
//

import Foundation

class CitiesViewModel {
    
    private(set) var rows = [Row]()
    private(set) var orginalRows = [Row]()
    
    public var didUpdated: ((CitiesViewModel) -> Void)?
    
    init() {
        self.buildData()
    }
    
    public func rows(atIndex indexPath: IndexPath) -> Row? {
        return indexPath.row < rows.count ? rows[indexPath.row] : nil
    }
    
    public func numberOfRows() -> Int {
        return rows.count
    }
    
    ///Filter the data from local array
    public func filterCity(prefix: String) {
        if prefix.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            self.resetFilter()
            return
        }
        let filteredCity = self.orginalRows.filter { row in
            if let row = row as? City {
                return row.name.lowercased().hasPrefix(prefix.lowercased())
            }
            return false
        }
        self.rows = filteredCity
        self.didUpdated?(self)
    }
    
    public func refreshData() {
        self.buildData()
    }
    
    public func resetFilter() {
        self.rows = orginalRows
        self.didUpdated?(self)
    }
    
}

extension CitiesViewModel {
    ///Build data for ViewModel
    private func buildData() {
        APIServices.shared.fetchAllCities { (rows, error) in
            guard error == nil, let rows = rows else {
                return
            }
            self.rows = rows
            self.orginalRows = rows
            self.didUpdated?(self)
        }
    }
}
