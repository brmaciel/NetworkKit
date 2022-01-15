//
//  MainWorkerTests.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import XCTest
@testable import NetworkKit

class MainWorkerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: MainWorker!
    
    
    // MARK: Setup and TearDown
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func setupMainWorker(with provider: BackendProvider) {
        sut = MainWorker(provider: provider)
    }
    
    
    // MARK: - Tests
    
    func test_makeRequest_withCompletionParameter() {
        // Given
        let providerSpy = BackendProviderSpy()
        setupMainWorker(with: providerSpy)
        
        // When
        sut.makeRequest(request: RequestDummy(), completion: { _ in })
        
        // Then
        XCTAssert(providerSpy.requestCalled,
                  "makeRequest(request:completion:) should call backendProvider.request(parameters:completion:")
    }
    
    func test_makeRequest_withMapResponseActionAndSuccessAndFailureParameters() {
        // Given
        let providerSpy = BackendProviderSpy()
        setupMainWorker(with: providerSpy)
        
        // When
        sut.makeRequest(request: RequestDummy(),
                        mapResponseAction: { (_: GenericResponseDummy) in return nil },
                        success: { (_: GenericModelDummy, _) in },
                        failure: { _ in })
        
        // Then
        XCTAssert(providerSpy.requestCalled,
                  "makeRequest(request:mapResponseAction:success:failure:) should call backendProvider.request(parameters:completion:")
    }
    
    func test_makeRequest_withMapResponseActionAndModelSuccessAndFailureParameters() {
        // Given
        let providerSpy = BackendProviderSpy()
        setupMainWorker(with: providerSpy)
        
        // When
        sut.makeRequest(request: RequestDummy(),
                        mapResponseAction: { (_: GenericResponseDummy) in return nil },
                        success: { (_: GenericModelDummy) in },
                        failure: { _ in })
        
        // Then
        XCTAssert(providerSpy.requestCalled,
                  "makeRequest(request:mapResponseAction:success:failure:) should call backendProvider.request(parameters:completion:")
    }
    
    // MARK: - Test callbacks
    
    func test_makeRequest_withCompletionParameter_CompletionCallback() {
        // Given
        let successResponseStub = NetworkResponseGenerator.successStub
        setupMainWorker(with: BackendProviderFake(forceResponse: successResponseStub))
        
        // When
        var completionCallbackCalled = false
        sut.makeRequest(request: RequestDummy(), completion: { _ in
            completionCallbackCalled = true
        })
        
        // Then
        XCTAssert(completionCallbackCalled,
                  "makeRequest(request:completion:) should callback completion closure")
    }
    
    func test_makeRequest2_Success() {
        // Given
        let successResponseStub = NetworkResponseGenerator.successStub
        setupMainWorker(with: BackendProviderFake(forceResponse: successResponseStub))

        // When
        var isSuccess: Bool = false
        sut.makeRequest(request: RequestDummy(),
                        mapResponseAction: { (_: GenericResponseDummy) in GenericModelDummy() },
                        success: { (_: GenericModelDummy) in
                            isSuccess = true
                        },
                        failure: { _ in })

        // Then
        XCTAssert(isSuccess,
                  "makeRequest(request:mapResponseAction:success:(_:)failure:) when network request is a success should callback the success closure")
    }
    
    func test_makeRequest_Success() {
        // Given
        let successResponseStub = NetworkResponseGenerator.successStub
        setupMainWorker(with: BackendProviderFake(forceResponse: successResponseStub))

        // When
        var isSuccess: Bool = false
        sut.makeRequest(request: RequestDummy(),
                        mapResponseAction: { (_: GenericResponseDummy) in GenericModelDummy() },
                        success: { (_: GenericModelDummy,_) in
                            isSuccess = true
                        },
                        failure: { _ in })

        // Then
        XCTAssert(isSuccess,
                  "makeRequest(request:mapResponseAction:success:(_:_:)failure:) when network request is a success should callback the success closure")
    }
    
    func test_makeRequest_Failure_withFailureResult() {
        // Given
        let failureResponseStub = NetworkResponseGenerator.failureStub
        setupMainWorker(with: BackendProviderFake(forceResponse: failureResponseStub))

        // When
        var isSuccess: Bool = true
        sut.makeRequest(request: RequestDummy(),
                        mapResponseAction: { (_: GenericResponseDummy) in GenericModelDummy() },
                        success: { (_: GenericModelDummy,_) in },
                        failure: { _ in
                            isSuccess = false
                        })

        // Then
        XCTAssertFalse(isSuccess,
                       "makeRequest(request:mapResponseAction:success:(_:_:)failure:) when network request is a failure should callback the failure closure")
    }
    
    func test_makeRequest_Failure_WithSuccessResultAndNilData() {
        // Given
        var failureResponseStub = NetworkResponseGenerator.successStub
        failureResponseStub.data = nil
        setupMainWorker(with: BackendProviderFake(forceResponse: failureResponseStub))

        // When
        var isSuccess: Bool = true
        sut.makeRequest(request: RequestDummy(),
                        mapResponseAction: { (_: GenericResponseDummy) in GenericModelDummy() },
                        success: { (_: GenericModelDummy,_) in },
                        failure: { _ in
                            isSuccess = false
                        })

        // Then
        XCTAssertFalse(isSuccess,
                       "makeRequest(request:mapResponseAction:success:(_:_:)failure:) when network request is a success but has no data should callback the failure closure")
    }
    
    func test_makeRequest_Failure_WithSuccessResultAndFailsDecoding() {
        // Given
        var failureResponseStub = NetworkResponseGenerator.successStub
        failureResponseStub.data = "{error decoding}".data(using: .utf8)
        setupMainWorker(with: BackendProviderFake(forceResponse: failureResponseStub))

        // When
        var isSuccess: Bool = true
        sut.makeRequest(request: RequestDummy(),
                        mapResponseAction: { (_: GenericResponseDummy) in GenericModelDummy() },
                        success: { (_: GenericModelDummy,_) in },
                        failure: { _ in
                            isSuccess = false
                        })

        // Then
        XCTAssertFalse(isSuccess,
                       "makeRequest(request:mapResponseAction:success:(_:_:)failure:) when network request is a success but can't decode data should callback the failure closure")
    }
    
    func test_makeRequest_Failure_WithSuccessResultAndFailsMappingResponse() {
        // Given
        let failureResponseStub = NetworkResponseGenerator.successStub
        setupMainWorker(with: BackendProviderFake(forceResponse: failureResponseStub))

        // When
        var isSuccess: Bool = true
        sut.makeRequest(request: RequestDummy(),
                        mapResponseAction: { (_: GenericResponseDummy) in nil },
                        success: { (_: GenericModelDummy,_) in },
                        failure: { _ in
                            isSuccess = false
                        })

        // Then
        XCTAssertFalse(isSuccess,
                       "makeRequest(request:mapResponseAction:success:(_:_:)failure:) when network request is a success but can't decode data should callback the failure closure")
    }
}
