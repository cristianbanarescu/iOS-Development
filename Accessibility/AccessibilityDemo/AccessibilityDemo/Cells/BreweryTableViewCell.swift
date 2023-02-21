//
//  BreweryTableViewCell.swift
//  AccessibilityDemo
//
//  Created by Cristian Banarescu on 21.02.2023.
//

import UIKit

class BreweryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var breweryNameLabel: UILabel!
    
    // MARK: - Public

    func configure(with breweryName: String) {
        breweryNameLabel.text = breweryName
    }
}

// MARK: - Identifiable

extension BreweryTableViewCell: Identifiable {
    static var nibName: String { "BreweryTableViewCell" }
    static var identifier: String { nibName }
}
