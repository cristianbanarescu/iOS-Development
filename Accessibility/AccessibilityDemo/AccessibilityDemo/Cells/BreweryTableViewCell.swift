//
//  BreweryTableViewCell.swift
//  AccessibilityDemo
//
//  Created by Cristian Banarescu on 21.02.2023.
//

import UIKit

class BreweryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!

    // MARK: - Public

    func configure(with brewery: Brewery) {
        nameLabel.text = brewery.name
        stateLabel.text = brewery.state
        countryLabel.text = brewery.country
    }
}

// MARK: - Identifiable

extension BreweryTableViewCell: Identifiable {
    static var nibName: String { "BreweryTableViewCell" }
    static var identifier: String { nibName }
}

// TODO
// add support for Voice Over and Dynamic Type
