//
//  DefaultApiRequesterTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import XCTest
@testable import NetworkKit

class DefaultApiRequesterTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: DefaultApiRequester!
    
    var validUrl = URL(string: "https://www.google.com.br")
    
    // MARK: Setup and TearDown
    override func setUp() {
        super.setUp()
        
        sut = DefaultApiRequester()
        sut.urlSession = URLSessionGenerator.fake
    }
    
    override func tearDown() {
        sut = nil
        URLProtocolFake.responseStub = nil
        
        super.tearDown()
    }
    
    
    // MARK: - Tests
    
    func test_request_withNilUrl() throws {
        // Given
        let url: URL? = nil
        
        // When
        var response: RestResponse?
        sut.request(url: url,
                    body: nil,
                    method: .get,
                    headers: ["" : ""]) { networkResponse in
            response = networkResponse as? RestResponse
        }
        
        // Then
        XCTAssertNil(url)
        let result = try XCTUnwrap(response?.result)
        guard case NetworkResponseResult.failure(.urlError) = result else {
            XCTFail("request(url:body:method:headers:completion:) when url is nil should callback response with result .failure(.urlError)")
            return }
    }
    
    func test_request_withError() throws {
        // Given
        let errorStub = ErrorDouble.dummy
        URLProtocolFake.responseStub = URLProtocolFake.URLResponseStub(errorStub: errorStub)
        
        let expectation = self.expectation(description: "request with error expectation")
        
        // When
        sut.request(url: validUrl,
                    body: nil,
                    method: .get,
                    headers: ["" : ""]) { response in
            // Then
            if case NetworkResponseResult.failure(.taskError(_)) = response.result {}
            else {
                XCTFail("request(url:body:method:headers:completion:) when receives error should callback response with result .failure(.taskError(_))")
            }
            
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_request_withNoHttpResponse() throws {
        // Given
        URLProtocolFake.responseStub = URLProtocolFake.URLResponseStub(responseDataStub: "{}".data(using: .utf8)!)
        
        let expectation = self.expectation(description: "request with no https request expectation")
        
        // When
        sut.request(url: validUrl,
                    body: nil,
                    method: .get,
                    headers: ["" : ""]) { response in
            // Then
            if case NetworkResponseResult.failure(.noResponse) = response.result {}
            else {
                XCTFail("request(url:body:method:headers:completion:) when receives no HTTPURLResponse should callback response with result .failure(.noResponse)")
            }
            
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_request_withFailureStatusCode() throws {
        // Given
        let invalidStatusCode = 400
        let httpUrlResponseStub = HTTPURLResponse(url: URL(string: "https://www.globo.com")!,
                                                  statusCode: invalidStatusCode,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        
        URLProtocolFake.responseStub = URLProtocolFake.URLResponseStub(httpUrlResponseStub: httpUrlResponseStub,
                                                                       responseDataStub: "{}".data(using: .utf8)!)
        
        let expectation = self.expectation(description: "request with no https request expectation")
        
        // When
        sut.request(url: validUrl,
                    body: nil,
                    method: .get,
                    headers: ["" : ""],
                    successStatusCodeRange: 200...299) { response in
            // Then
            if case NetworkResponseResult.failure(.responseStatusCode(code: invalidStatusCode)) = response.result {}
            else {
                XCTFail("request(url:body:method:headers:completion:) when receives response with not success status code should callback response with result .responseStatusCode(statusCode)")
            }
            
            expectation.fulfill()
        }
        
        // Then
        XCTAssertNotNil(httpUrlResponseStub)
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_request_withSuccess() throws {
        // Given
        let httpUrlResponseStub = HTTPURLResponse(url: URL(string: "https://www.globo.com")!,
                                                  statusCode: 200,
                                                  httpVersion: nil,
                                                  headerFields: nil)
        URLProtocolFake.responseStub = URLProtocolFake.URLResponseStub(httpUrlResponseStub: httpUrlResponseStub,
                                                                       responseDataStub: "{}".data(using: .utf8)!)
        
        let expectation = self.expectation(description: "request with no https request expectation")
        
        // When
        sut.request(url: validUrl,
                    body: nil,
                    method: .get,
                    headers: ["" : ""]) { response in
            // Then
            if case NetworkResponseResult.success = response.result {}
            else {
                XCTFail("request(url:body:method:headers:completion:) when receives success response should callback response with result .success")
            }
            
            expectation.fulfill()
        }
        
        // Then
        XCTAssertNotNil(httpUrlResponseStub)
        wait(for: [expectation], timeout: 2.0)
    }
}
