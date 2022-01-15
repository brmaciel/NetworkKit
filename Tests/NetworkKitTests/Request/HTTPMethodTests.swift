//
//  HTTPMethodTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import XCTest
@testable import NetworkKit

class HTTPMethodTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: HTTPMethod!
    
    
    // MARK: Setup and TearDown
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    func test_getCase() {
        // Given
        sut = .get
        
        // When
        
        // Then
        XCTAssertEqual(sut.rawValue,
                       "GET",
                       "HTTPMethod.get.rawValue should be 'GET'")
    }
    
    func test_postCase() {
        // Given
        sut = .post
        
        // When
        
        // Then
        XCTAssertEqual(sut.rawValue,
                       "POST",
                       "HTTPMethod.post.rawValue should be 'POST'")
    }
    
    func test_putCase() {
        // Given
        sut = .put
        
        // When
        
        // Then
        XCTAssertEqual(sut.rawValue,
                       "PUT",
                       "HTTPMethod.put.rawValue should be 'PUT'")
    }
    
    func test_deleteCase() {
        // Given
        sut = .delete
        
        // When
        
        // Then
        XCTAssertEqual(sut.rawValue,
                       "DELETE",
                       "HTTPMethod.delete.rawValue should be 'DELETE'")
    }
    
    func test_patchCase() {
        // Given
        sut = .patch
        
        // When
        
        // Then
        XCTAssertEqual(sut.rawValue,
                       "PATCH",
                       "HTTPMethod.patch.rawValue should be 'PATCH'")
    }
    
    func test_headCase() {
        // Given
        sut = .head
        
        // When
        
        // Then
        XCTAssertEqual(sut.rawValue,
                       "HEAD",
                       "HTTPMethod.head.rawValue should be 'HEAD'")
    }
}
