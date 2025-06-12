//
//  Untitled.swift
//  RickAndMortyApp
//
//  Created by Joan Marc Sanahuja on 8/6/25.
//

import XCTest
@testable import Presentation

final class RickAndMortyAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func test_characterList_displaysCharacters() {
        let filtersButton = app.buttons.matching(identifier: UITestIdentifiers.CharacterList.filtersButton).firstMatch
        XCTAssertTrue(filtersButton.waitForExistence(timeout: 5))
        
        let character = app.staticTexts.matching(identifier: UITestIdentifiers.CharacterList.characterNamePrefix + "1").firstMatch
        XCTAssertTrue(character.waitForExistence(timeout: 5))
    }
    
    
    func test_openFiltersScreen() {
        let filtersButton = app.buttons.matching(identifier: UITestIdentifiers.CharacterList.filtersButton).firstMatch
        XCTAssertTrue(filtersButton.waitForExistence(timeout: 5))
        
        filtersButton.tap()
        
        let screen = app.otherElements[UITestIdentifiers.CharacterList.filtersView]
        XCTAssertTrue(screen.waitForExistence(timeout: 5))
    }

    func test_navigateToCharacterDetail() {
        let character = app.staticTexts.matching(identifier: UITestIdentifiers.CharacterList.characterNamePrefix + "1").firstMatch
        XCTAssertTrue(character.waitForExistence(timeout: 5))
        
        character.tap()
        
        let navBarTitle = app.staticTexts.matching(identifier: UITestIdentifiers.CharacterDetail.screenTitle).firstMatch
        XCTAssertTrue(navBarTitle.waitForExistence(timeout: 10))
    }
    
    func test_searchCharacters() {
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))
        
        searchField.tap()
        searchField.typeText("Rick")
        
        let character = app.staticTexts.matching(identifier: UITestIdentifiers.CharacterList.characterNamePrefix + "1").firstMatch
        XCTAssertTrue(character.waitForExistence(timeout: 5))
    }
    
    func test_openEpisodesListFromCharacterDetail() {
        let firstCharacter = app.staticTexts.matching(identifier: UITestIdentifiers.CharacterList.characterNamePrefix + "1").firstMatch
        XCTAssertTrue(firstCharacter.waitForExistence(timeout: 5))
        
        firstCharacter.tap()
        
        let seeEpisodesButton = app.buttons.matching(identifier: UITestIdentifiers.CharacterDetail.seeEpisodesButton).firstMatch
        XCTAssertTrue(seeEpisodesButton.waitForExistence(timeout: 5))
        
        seeEpisodesButton.tap()
        
        let screenText = app.staticTexts.matching(identifier: UITestIdentifiers.EpisodesList.screen).firstMatch
        XCTAssertTrue(screenText.waitForExistence(timeout: 10))
    }
}
