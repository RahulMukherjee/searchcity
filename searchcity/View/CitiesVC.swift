//
//  CitiesVC.swift
//  searchcity
//
//  Created by Rahul Mukherjee on 24/06/19.
//  Copyright © 2019 Rahul Mukherjee. All rights reserved.
//

import UIKit
import CoreLocation

class CitiesVC: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var citiesTable: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var locationManager: CLLocationManager?
    
    private var viewModel: CitiesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpSearchBar()
        self.activityIndicator.startAnimating()
        self.registerCell()
        viewModel = CitiesViewModel()
        self.registerCallback()
        locationManager = CLLocationManager()
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.delegate = self
        self.citiesTable.rowHeight = UITableView.automaticDimension;
        self.citiesTable.estimatedRowHeight = 44.0;
    }
    
    private func setUpSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cities"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func registerCell() {
        self.citiesTable.register(CityTableViewCell.nib(), forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    private func registerCallback() {
        if let viewModel = viewModel {
            viewModel.didUpdated = { [weak self] _ in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    self.activityIndicator.stopAnimating()
                    self.citiesTable.reloadData()
                }
            }
        }
    }
    
}

extension CitiesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel {
            return viewModel.numberOfRows()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let viewModel = viewModel else { return UITableViewCell() }
        if let cityModel = viewModel.rows(atIndex: indexPath) as? City, let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell {
            cell.configure(city: cityModel)
            return cell
        }
        return UITableViewCell()
    }
}

extension CitiesVC: UISearchResultsUpdating {
    ///SearchBar delegate
    func updateSearchResults(for searchController: UISearchController) {
        guard let viewModel = viewModel else { return }
        if let searchText = searchController.searchBar.text, searchText.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                viewModel.filterCity(prefix: searchText)
        } else {
            viewModel.resetFilter()
        }
    }
}

extension CitiesVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if( status == .authorizedWhenInUse ||
            status ==  .authorizedAlways) {
            appLog("Got the Permision for Location")
        } else {
            appLog("Nops! Location permision denied")
        }
    }
}
