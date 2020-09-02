//
//  PokeDemoTests.swift
//  PokeDemoTests
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import XCTest
@testable import PokeDemo

class PokeDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPokemonsArraySort() {
        var testData = [PokemonBrief(noDBIndex: nil, name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                        PokemonBrief(noDBIndex: nil, name: "charmander", url: "https://pokeapi.co/api/v2/pokemon/4/"),
                        PokemonBrief(noDBIndex: nil, name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
                        PokemonBrief(noDBIndex: nil, name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/")]
        let homeVM = HomeViewModel()
        homeVM.sortByURL(items: &testData)
        XCTAssertEqual(testData.last?.name, "charmander")
    }
    
    func testURLCreation() {
        let queryItems = [URLQueryItem(name: "offset", value: "\(50)")]
        let  url = NetworkingUtilities.buildURL(path: "/pokemon", queryItems: queryItems)
        XCTAssertEqual(url?.absoluteString, "https://pokeapi.co/api/v2/pokemon?offset=50")
    }
    
    func testMailValidation() {
        let validMail = "ita@mail.com"
        XCTAssertTrue(ValidationChecker.validateEmail(mail: validMail))
        let invalidMail = "Ita@mail"
        XCTAssertFalse(ValidationChecker.validateEmail(mail: invalidMail))
    }
    
    func testValidatePassword() {
        let validPassword = "Yello124."
        XCTAssertTrue(ValidationChecker.validatePassword(password: validPassword))
        let lenghtInvalidPassword = "yello1."
        XCTAssertFalse(ValidationChecker.validatePassword(password: lenghtInvalidPassword))
        let charsInvalidPassword = "yello1245"
        XCTAssertFalse(ValidationChecker.validatePassword(password: charsInvalidPassword))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
