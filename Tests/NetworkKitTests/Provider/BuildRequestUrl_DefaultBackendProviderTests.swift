//
//  BuildRequestUrl_DefaultBackendProviderTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import XCTest
@testable import NetworkKit

class BuildRequestUrl_DefaultBackendProviderTests: XCTestCase {
    
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
    
    func test_buildRequestUrl_emptyResourcePath() throws {
        // Given
        let resourcePath = ""
        
        // When
        let url = sut.buildRequestUrl(resourcePath: resourcePath)
        
        // Then
        let urlUnwrap = try XCTUnwrap(url,
                                      "buildRequestUrl(resourcePath:) when resourcePath is empty should NOT return nil")
        XCTAssertEqual(urlUnwrap.absoluteString,
                       sut.baseURL,
                       "buildRequestUrl(resourcePath:) when resourcePath is empty should return baseUrl")
    }
    
    func test_buildRequestUrl_withResourcePath() throws {
        // Given
        sut.baseURL = "https://www.google.com"
        let resourcePath = "/endpoint/pathParam/pathValue?queryParam=queryValue"
        
        // When
        let url = sut.buildRequestUrl(resourcePath: resourcePath)
        
        // Then
        let urlUnwrap = try XCTUnwrap(url,
                                      "buildRequestUrl(resourcePath:) when resourcePath is NOT empty should NOT return nil")
        XCTAssertEqual(urlUnwrap.absoluteString,
                       "https://www.google.com/endpoint/pathParam/pathValue?queryParam=queryValue",
                       "buildRequestUrl(resourcePath:) should return string in format: baseUrl + resourcePath")
    }
    
    func test_buildRequestUrl_withResourcePath_addingPercentEncoding() throws {
        // Given
        sut.baseURL = "https://www.google.com"
        let resourcePath = "/endpoint/pathParam/path value?queryParam=query value"
        
        // When
        let url = sut.buildRequestUrl(resourcePath: resourcePath)
        
        // Then
        let urlUnwrap = try XCTUnwrap(url,
                                      "buildRequestUrl(resourcePath:) when resourcePath is NOT empty should NOT return nil")
        XCTAssertEqual(urlUnwrap.absoluteString,
                       "https://www.google.com/endpoint/pathParam/path%20value?queryParam=query%20value",
                       "buildRequestUrl(resourcePath:) should add percent encoding in resourcePath when needed")
    }
    
}
