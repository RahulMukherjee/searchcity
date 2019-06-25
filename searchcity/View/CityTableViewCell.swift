//
//  CityTableViewCell.swift
//  searchcity
//
//  Created by Rahul Mukherjee on 24/06/19.
//  Copyright © 2019 Rahul Mukherjee. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCityCountry: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    
    public static var identifier = "CityTableViewCell"
    private var viewModel: CityCellViewModel?
    
    public static func nib() -> UINib {
        return UINib(nibName: "CityTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure(city: City) {
        viewModel = CityCellViewModel(city: city)
        self.setUpCell()
    }
    
    private func setUpCell() {
        if let viewModel = viewModel {
            lblCityCountry.text = viewModel.cityCountry
            self.lblDistance.text = viewModel.distance
        }
        self.setNeedsLayout()
    }
    
}
