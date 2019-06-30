//
//  weatherappUITests.swift
//  weatherappUITests
//
//  Created by Korfant, Tomas on 18/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import XCTest

class weatherappUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    func testExample() {

        let enterCityNameSearchField = app.searchFields["Enter city name"]
        XCTAssertTrue(enterCityNameSearchField.exists)
        enterCityNameSearchField.tap()
        enterCityNameSearchField.typeText("Kosi")

        let tablesQuery = app.tables
        let cellKosice = tablesQuery.cells.staticTexts["Kosice"]
        wait(element: cellKosice, duration: 1)

        XCTAssertTrue(cellKosice.exists)
        cellKosice.tap()

        let tempLabel = app.staticTexts[WeatherDetailsAccessibilityID.tempLabel]
        wait(element: tempLabel, duration: 1)

        XCTAssertTrue(tempLabel.exists)
        XCTAssertTrue(app.staticTexts[WeatherDetailsAccessibilityID.cityLabel].exists)
        XCTAssertTrue(app.staticTexts[WeatherDetailsAccessibilityID.maxMinTempLabel].exists)
        XCTAssertTrue(app.staticTexts[WeatherDetailsAccessibilityID.skyLabel].exists)
        let backButton = app.buttons[WeatherDetailsAccessibilityID.backButton]
        XCTAssertTrue(backButton.exists)
        backButton.tap()

        XCTAssertTrue(enterCityNameSearchField.exists)
        enterCityNameSearchField.tap()
        enterCityNameSearchField.buttons["Clear text"].tap()
        enterCityNameSearchField.typeText("Brati")

        let bratislavaCell = app.tables.cells.staticTexts["Bratislava"]
        wait(element: bratislavaCell, duration: 1)

        XCTAssertTrue(bratislavaCell.exists)
        XCTAssertFalse(cellKosice.exists)
        bratislavaCell.tap()

        wait(element: backButton, duration: 1)
        XCTAssertTrue(backButton.exists)
        backButton.tap()
        XCTAssertTrue(enterCityNameSearchField.exists)
    }

    private func wait(element: XCUIElement, duration: TimeInterval) {
        let predicate = NSPredicate(format: "exists == true")
        let _ = expectation(for: predicate, evaluatedWith: element, handler: nil)

        // We use a buffer here to avoid flakiness with Timer on CI
        waitForExpectations(timeout: duration + 0.5)
    }
}
