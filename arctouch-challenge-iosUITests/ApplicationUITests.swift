//
//  arctouch_challenge_iosUITests.swift
//  arctouch-challenge-iosUITests
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import XCTest

class ApplicationUITests: XCTestCase {
    
    var app: XCUIApplication?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        app = XCUIApplication()
        app?.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testApp() {
        lazyLoading()
        details(of: app?.collectionViews.element.cells.element(boundBy: 1))
        search(for: "Star Wars")
    }
    
    func lazyLoading() {
        if app?.collectionViews.element.waitForExistence(timeout: 5) != nil,
            app?.collectionViews.element.cells.element(boundBy: 0).waitForExistence(timeout: 5) == true {
            app?.collectionViews.element.swipeUp()
            app?.collectionViews.element.swipeUp()
            app?.collectionViews.element.swipeUp()
            app?.collectionViews.element.swipeUp()
        }
    } 
    
    func details(of cell: XCUIElement?) {
        if cell?.staticTexts.element(boundBy: 0).waitForExistence(timeout: 5) == true,
            let cellLabel = cell?.staticTexts.element(boundBy: 0).label {
            cell?.tap()
            if let exists = app?.navigationBars[cellLabel].waitForExistence(timeout: 5) {
                XCTAssert(exists, "movie.title is not on the nav title")
                app?.navigationBars.element(boundBy: 0).buttons.element(boundBy: 0).tap()
            } else {
                XCTAssert(false, "couldn't load movie's details")
            }
        }
    }
    
    func search(for query: String) {
        app?.searchFields.element(boundBy: 0).tap()
        app?.searchFields.element(boundBy: 0).typeText(query)
        Thread.sleep(forTimeInterval: 2.5)
        if app?.collectionViews.element.cells.element(boundBy: 0).waitForExistence(timeout: 5) == true {
            let cell = app?.collectionViews.element.cells.element(boundBy: 0)
            let cellLabel = cell?.staticTexts.element(boundBy: 0).label
            XCTAssert(cellLabel?.contains(query) ?? false, "movie.title \(String(describing: cellLabel)) doesn't match the searched query \(query)")
        }
    }
    
}
