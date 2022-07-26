//
//  BuildQueryString_DefaultBackendProviderTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import XCTest
@testable import NetworkKit

class BuildQueryString_DefaultBackendProviderTests: XCTestCase {
    
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
    
    func test_buildQueryString_nil() {
        // Given
        let queryParams: [(String, String)]? = nil
        
        // When
        let queryString = sut.buildQueryString(from: queryParams)
        
        // Then
        XCTAssertNil(queryString,
                     "buildQueryString(from:) when queryParameters is nil should return nil")
    }
    
    func test_buildQueryString_empty() {
        // Given
        let queryParams: [(String, String)]? = []
        
        // When
        let queryString = sut.buildQueryString(from: queryParams)
        
        // Then
        XCTAssertNil(queryString,
                     "buildQueryString(from:) when queryParameters is empty should return nil")
    }
    
    func test_buildQueryString_withOneValue() {
        // Given
        let queryParams: [(String, String)]? = [
            ("param1", "value1")
        ]
        
        // When
        let queryString = sut.buildQueryString(from: queryParams)
        
        // Then
        XCTAssertEqual(queryString,
                       "?param1=value1",
                       "buildQueryString(from:) should return string in format '?key=value'")
    }
    
    func test_buildQueryString_withMoreThanOneValue() {
        // Given
        let queryParams: [(String, String)]? = [
            ("param1", "value1"),
            ("param2", "value2")
        ]
        
        // When
        let queryString = sut.buildQueryString(from: queryParams)
        
        // Then
        XCTAssert(queryString == "?param1=value1&param2=value2",
                  "buildQueryString(from:) should return string in format '?param1=value1&param2=value2'")
    }
    
}
