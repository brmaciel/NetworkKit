//
//  URLSessionDoubles.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import Foundation
@testable import NetworkKit

struct URLSessionGenerator {
    static var fake: URLSession = {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolFake.self]
        
        return URLSession(configuration: config)
    }()
}

class URLProtocolFake: URLProtocol {
    
    struct URLResponseStub {
        var httpUrlResponseStub: HTTPURLResponse?
        var responseDataStub: Data?
        var errorStub: Error?
    }
    
    static var responseStub: URLResponseStub?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let errorStub = URLProtocolFake.responseStub?.errorStub {
            client?.urlProtocol(self, didFailWithError: errorStub)
        } else {
            client?.urlProtocol(self, didLoad: URLProtocolFake.responseStub?.responseDataStub ?? Data())
            if let urlResponse = URLProtocolFake.responseStub?.httpUrlResponseStub {
                client?.urlProtocol(self, didReceive: urlResponse, cacheStoragePolicy: .notAllowed)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        
    }
}
