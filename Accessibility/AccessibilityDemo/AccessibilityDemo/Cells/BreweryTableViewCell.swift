//
//  BreweryTableViewCell.swift
//  AccessibilityDemo
//
//  Created by Cristian Banarescu on 21.02.2023.
//

import UIKit

class BreweryTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!    
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setupFonts()
    }

    // MARK: - Public

    func configure(with brewery: Brewery) {
        nameLabel.text = brewery.name
        stateLabel.text = brewery.state
        countryLabel.text = brewery.country
    }
}

// MARK: - Private

private extension BreweryTableViewCell {
    func setupFonts() {
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2, compatibleWith: nil)
        stateLabel.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: nil)
        countryLabel.font = UIFont.preferredFont(forTextStyle: .body, compatibleWith: nil)
    }
}

// MARK: - Identifiable

extension BreweryTableViewCell: Identifiable {
    static var nibName: String { "BreweryTableViewCell" }
    static var identifier: String { nibName }
}

// TODO
// add support for Voice Over and Dynamic Type
