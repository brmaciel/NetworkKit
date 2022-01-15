//
//  Request_DefaultBackendProviderTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import XCTest
@testable import NetworkKit

class Request_DefaultBackendProviderTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: DefaultBackendProvider!
    
    var apiRequesterSpy: ApiRequesterSpy!
    
    // MARK: Setup and TearDown
    override func setUp() {
        super.setUp()
        
        apiRequesterSpy = ApiRequesterSpy()
        sut = DefaultBackendProvider(baseUrl: "https://localhost:8080")
        sut.apiRequester = apiRequesterSpy
    }
    
    override func tearDown() {
        sut = nil
        apiRequesterSpy = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    func test_request() throws {
        // Given
        let parameters: [AnyHashable: Any] = [
            "header"   : [:] as [String: String],
            "body"     : Data(),
            "path"     : [:] as [AnyHashable: Any],
            "query"    : [:] as [AnyHashable: Any],
            "endpoint" : "endpoint",
            "method"   : HTTPMethod.get
        ]
        
        // When
        sut.request(parameters: parameters, completion: { _ in })
        
        // Then
        XCTAssert(apiRequesterSpy.requestCalled,
                  "request(parameters:completion:) should call apiRequester.request")
    }
    
    func test_request_informedMethodParameter() throws {
        // Given
        let parameters: [AnyHashable: Any] = [
            "header"   : [:] as [String: String],
            "body"     : Data(),
            "path"     : [:] as [AnyHashable: Any],
            "query"    : [:] as [AnyHashable: Any],
            "endpoint" : "endpoint",
            "method"   : HTTPMethod.post
        ]
        
        // When
        sut.request(parameters: parameters, completion: { _ in })
        
        // Then
        XCTAssertNotNil(parameters["method"])
        XCTAssert(apiRequesterSpy.currentMethod == HTTPMethod.post.rawValue,
                  "request(parameters:completion:) when parameter 'method' is informed should pass the method to the apiRequester.request")
    }
    
    func test_request_notInformedMethodParameter() throws {
        // Given
        let parameters: [AnyHashable: Any] = [
            "header"   : [:] as [String: String],
            "body"     : Data(),
            "path"     : [:] as [AnyHashable: Any],
            "query"    : [:] as [AnyHashable: Any],
            "endpoint" : "endpoint"
        ]
        
        // When
        sut.request(parameters: parameters, completion: { _ in })
        
        // Then
        XCTAssertNil(parameters["method"])
        XCTAssert(apiRequesterSpy.currentMethod == HTTPMethod.get.rawValue,
                  "request(parameters:completion:) when parameter 'method' is NOT informed should use .get method")
    }
    
    func test_request_url() throws {
        // Given
        let parameters: [AnyHashable: Any] = [
            "header"   : [:] as [String: String],
            "body"     : Data(),
            "path"     : [:] as [AnyHashable: Any],
            "query"    : [:] as [AnyHashable: Any],
            "endpoint" : "endpoint",
            "method"   : HTTPMethod.get
        ]
        
        // When
        sut.request(parameters: parameters, completion: { _ in })
        
        // Then
        XCTAssertNotNil(apiRequesterSpy.currentUrl,
                        "request(parameters:completion:) should pass the url to the apiRequester.request")
    }
    
}
