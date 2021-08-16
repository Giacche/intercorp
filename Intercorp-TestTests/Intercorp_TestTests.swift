//
//  Intercorp_TestTests.swift
//  Intercorp-TestTests
//
//  Created by Lucas Giacche on 15/08/2021.
//

import XCTest
@testable import Intercorp_Test

class Intercorp_TestTests: XCTestCase {
    
    var model: User!

    override func setUp() {
        model = User(userFirstName: "Lucas", userLastName: "Giacche", userAge: "26", userDateBirth: "10 Octubre 1994")
    }

    override func tearDown() {
        model = nil
    }
    
    func testUserName(){
        XCTAssertEqual(model.userFirstName, "Lucas")
    }
    
    func testUserLastName(){
        XCTAssertEqual(model.userLastName, "Giacche")
    }
    
    func testUserAge(){
        XCTAssertEqual(model.userAge, "26")
    }
    
    func testUserDateBirth(){
        XCTAssertEqual(model.userDateBirth, "10 Octubre 1994")
    }
}
