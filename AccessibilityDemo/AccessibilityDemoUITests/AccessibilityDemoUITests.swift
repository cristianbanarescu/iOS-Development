//
//  AccessibilityDemoUITests.swift
//  AccessibilityDemoUITests
//
//  Created by Cristian Banarescu on 22.02.2023.
//

import XCTest

final class AccessibilityDemoUITests: XCTestCase {

    func testBreweries() throws {
        let app = XCUIApplication()
        app.launch()
        
        let cells = app.tables.cells
        
        for cell in cells.allElementsBoundByAccessibilityElement {
            XCTAssertEqual(cell.identifier, "BreweryTableViewCell")
            XCTAssertTrue(cell.label.contains("Brewery name"))
        }
    }
}
