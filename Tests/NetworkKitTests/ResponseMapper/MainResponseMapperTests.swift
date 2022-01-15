//
//  MainResponseMapperTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//


import XCTest
@testable import NetworkKit

class MainResponseMapperTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: MainResponseMapper<GenericResponseDummy, GenericModelDummy>!
    
    
    // MARK: Setup and TearDown
    override func setUp() {
        super.setUp()
        
        sut = MainResponseMapper<GenericResponseDummy, GenericModelDummy>()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    func test_map() {
        // Given
        
        // When
        let mappedModel = sut.map(GenericResponseDummy())
        
        // Then
        XCTAssertNil(mappedModel,
                     "MainResponseMapper map(_:) should always return nil")
    }
    
}
