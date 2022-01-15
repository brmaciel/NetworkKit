//
//  NetworkResponseErrorTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import XCTest
@testable import NetworkKit

class NetworkResponseErrorTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: NetworkResponseError!
    
    
    // MARK: Setup and TearDown
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    func test_urlError() {
        // Given
        sut = .urlError
        
        // When
        
        // Then
        XCTAssertEqual(sut.errorDescription,
                       "Error while creating url",
                       "NetworkResponseError.urlError.errorDescription should be ''")
    }
    
    func test_taskError() {
        // Given
        let errorStub = ErrorDouble.errorStub
        sut = .taskError(errorStub)
        
        // When
        
        // Then
        XCTAssertEqual(sut.errorDescription,
                       errorStub.localizedDescription,
                       "NetworkResponseError.taskError(error).errorDescription should be equal to error.localizedDescription")
    }
    
    func test_noResponse() {
        // Given
        sut = .noResponse
        
        // When
        
        // Then
        XCTAssertEqual(sut.errorDescription,
                       "Error while obtaining response",
                       "NetworkResponseError.noResponse.errorDescription should be 'Error while obtaining response'")
    }
    
    func test_responseStatusCode() {
        // Given
        let statusCode = 400
        sut = .responseStatusCode(code: statusCode)
        
        // When
        
        // Then
        XCTAssertEqual(sut.errorDescription,
                       "Request did fail with statusCode 400",
                       "NetworkResponseError.responseStatusCode(statusCode).errorDescription should be 'Request did fail with statusCode \(statusCode)'")
    }
    
}
