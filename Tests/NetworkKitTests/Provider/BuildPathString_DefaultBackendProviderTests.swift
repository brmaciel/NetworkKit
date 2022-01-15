//
//  BuildPathString_DefaultBackendProviderTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//


import XCTest
@testable import NetworkKit

class BuildPathString_DefaultBackendProviderTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: DefaultBackendProvider!
    
    
    // MARK: Setup and TearDown
    override func setUp() {
        super.setUp()
        
        sut = DefaultBackendProvider(baseUrl: "https://localhost:8080")
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    func test_buildPathString_nil() {
        // Given
        let pathParams: [AnyHashable : Any]? = nil
        
        // When
        let pathString = sut.buildPathString(from: pathParams)
        
        // Then
        XCTAssertNil(pathString,
                     "buildPathString(from:) when pathParameters is nil should return nil")
    }
    
    func test_buildPathString_empty() {
        // Given
        let pathParams: [AnyHashable : Any]? = [:]
        
        // When
        let pathString = sut.buildPathString(from: pathParams)
        
        // Then
        XCTAssertNil(pathString,
                     "buildPathString(from:) when pathParameters is empty should return nil")
    }
    
    func test_buildPathString_withOneValue() {
        // Given
        let pathParams: [AnyHashable : Any]? = [
            "param1" : "value1"
        ]
        
        // When
        let pathString = sut.buildPathString(from: pathParams)
        
        // Then
        XCTAssertEqual(pathString,
                       "/param1/value1",
                       "buildPathString(from:) should return string in format '/key/value'")
    }
    
    func test_buildPathString_withMoreThanOneValue() {
        // Given
        let pathParams: [AnyHashable : Any]? = [
            "param1" : "value1",
            "param2" : "value2"
        ]
        
        // When
        let pathString = sut.buildPathString(from: pathParams)
        
        // Then
        XCTAssert(pathString == "/param1/value1/param2/value2" || pathString == "/param2/value2/param1/value1",
                  "buildPathString(from:) should return string in format '/paramI/valueI/paramJ/valueJ'")
    }
    
}
