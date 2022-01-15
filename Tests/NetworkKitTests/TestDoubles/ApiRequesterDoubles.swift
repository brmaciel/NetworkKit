//
//  ApiRequesterDoubles.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import Foundation
@testable import NetworkKit

class ApiRequesterSpy: ApiRequester {
    var requestCalled = false
    
    var currentUrl: URL?
    var currentBody: Data?
    var currentMethod: String?
    var currentHeaders: [String: String]?
    var currentSuccessStatusCodeRange: ClosedRange<Int>?
    
    func request(url providerURL: URL?,
                 body jsonData: Data?,
                 method: HTTPMethod,
                 headers: [String: String]?,
                 successStatusCodeRange: ClosedRange<Int>,
                 completion: @escaping (NetworkResponse) -> Void) {
        requestCalled = true
        
        currentUrl = providerURL
        currentBody = jsonData
        currentMethod = method.rawValue
        currentHeaders = headers
        currentSuccessStatusCodeRange = successStatusCodeRange
    }
    
    func request(_ request: URLRequest,
                        successStatusCodeRange: ClosedRange<Int>,
                        completion: @escaping (NetworkResponse) -> Void) {
        requestCalled = true
        
        currentUrl = request.url
        currentBody = request.httpBody
        currentMethod = request.httpMethod
        currentHeaders = request.allHTTPHeaderFields
        currentSuccessStatusCodeRange = successStatusCodeRange
    }
}
