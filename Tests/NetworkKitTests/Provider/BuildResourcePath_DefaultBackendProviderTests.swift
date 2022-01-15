//
//  BuildResourcePath_DefaultBackendProviderTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import XCTest
@testable import NetworkKit

class BuildResourcePath_DefaultBackendProviderTests: XCTestCase {
    
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
    
    func test_buildResourcePath_allNilParameters() {
        // Given
        let endpoint: String? = nil
        let pathParams: [AnyHashable : Any]? = nil
        let queryParams: [AnyHashable : Any]? = nil
        
        // When
        let resourcePath = sut.buildResourcePath(endpoint: endpoint,
                                                pathParameters: pathParams,
                                                queryParameters: queryParams)
        
        // Then
        XCTAssertEqual(resourcePath,
                       "",
                       "buildResourcePath(endpoint:pathParameters:queryParameters:) when parameters are all nil should return '' (empty string)")
    }
    
    func test_buildResourcePath_allEmptyParameters() {
        // Given
        let endpoint: String? = ""
        let pathParams: [AnyHashable : Any]? = [:]
        let queryParams: [AnyHashable : Any]? = [:]
        
        // When
        let resourcePath = sut.buildResourcePath(endpoint: endpoint,
                                                 pathParameters: pathParams,
                                                 queryParameters: queryParams)
        
        // Then
        XCTAssertEqual(resourcePath,
                       "",
                       "buildResourcePath(endpoint:pathParameters:queryParameters:) when parameters are all empty should return '' (empty string)")
    }
    
    func test_buildResourcePath_withOnlyEndpoint() {
        // Given
        let endpoint: String? = "/endpoint"
        
        // When
        let resourcePath = sut.buildResourcePath(endpoint: endpoint,
                                                 pathParameters: nil,
                                                 queryParameters: nil)
        
        // Then
        XCTAssertEqual(resourcePath,
                       "/endpoint",
                       "buildResourcePath(endpoint:pathParameters:queryParameters:) when endpoint is not empty and the rest of parameters are all nil should return the endpoint")
    }
    
    func test_buildResourcePath_withOnlyEndpointAndPathParams() {
        // Given
        let endpoint: String? = "/endpoint"
        let pathParams: [AnyHashable : Any]? = ["pathParam1":"pathValue1"]
        
        // When
        let resourcePath = sut.buildResourcePath(endpoint: endpoint,
                                                 pathParameters: pathParams,
                                                 queryParameters: nil)
        
        // Then
        XCTAssertEqual(resourcePath,
                       "/endpoint/pathParam1/pathValue1",
                       "buildResourcePath(endpoint:pathParameters:queryParameters:) when endpoint and pathParameters are NOT empty should return string in format 'endpoint/pathParam/pathValue'")
    }
    
    func test_buildResourcePath_withOnlyEndpointAndQueryParams() {
        // Given
        let endpoint: String? = "/endpoint"
        let queryParams: [AnyHashable : Any]? = ["queryParam1":"queryValue1"]
        
        // When
        let resourcePath = sut.buildResourcePath(endpoint: endpoint,
                                                 pathParameters: nil,
                                                 queryParameters: queryParams)
        
        // Then
        XCTAssertEqual(resourcePath,
                       "/endpoint?queryParam1=queryValue1",
                       "buildResourcePath(endpoint:pathParameters:queryParameters:) when endpoint and queryParameters are NOT empty should return string in format 'endpoint?queryParam=queryValue'")
    }
    
    func test_buildResourcePath_withOnlyPathParamsAndQueryParam() {
        // Given
        let pathParams: [AnyHashable : Any]? = ["pathParam1":"pathValue1"]
        let queryParams: [AnyHashable : Any]? = ["queryParam1":"queryValue1"]
        
        // When
        let resourcePath = sut.buildResourcePath(endpoint: nil,
                                                 pathParameters: pathParams,
                                                 queryParameters: queryParams)
        
        // Then
        XCTAssertEqual(resourcePath,
                       "/pathParam1/pathValue1?queryParam1=queryValue1",
                       "buildResourcePath(endpoint:pathParameters:queryParameters:) when pathParameters and queryParameters are NOT empty should return string in format '/pathParam/pathValue?queryParam=queryValue'")
    }
    
    
    
    func test_buildResourcePath_withEndpointAndPathParamsAndQueryParam() {
        // Given
        let endpoint: String? = "/endpoint"
        let pathParams: [AnyHashable : Any]? = ["pathParam1":"pathValue1"]
        let queryParams: [AnyHashable : Any]? = ["queryParam1":"queryValue1"]
        
        // When
        let resourcePath = sut.buildResourcePath(endpoint: endpoint,
                                                 pathParameters: pathParams,
                                                 queryParameters: queryParams)
        
        // Then
        XCTAssertEqual(resourcePath,
                       "/endpoint/pathParam1/pathValue1?queryParam1=queryValue1",
                       "buildResourcePath(endpoint:pathParameters:queryParameters:) when all parameters are NOT empty should return string in format 'endpoint/pathParam/pathValue?queryParam=queryValue'")
    }
}
