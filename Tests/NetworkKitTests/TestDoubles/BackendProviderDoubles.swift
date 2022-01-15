//
//  BackendProviderDoubles.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import Foundation
@testable import NetworkKit

class BackendProviderDummy: BackendProvider {
    func request(parameters: [AnyHashable : Any], completion: @escaping (NetworkResponse) -> Void) {}
}

class BackendProviderSpy: BackendProvider {
    var requestCalled = false
    var currentParameters: [AnyHashable: Any]?
    
    func request(parameters: [AnyHashable : Any], completion: @escaping (NetworkResponse) -> Void) {
        requestCalled = true
        currentParameters = parameters
    }
}

class BackendProviderFake: BackendProvider {
    var forceResponse: NetworkResponse
    
    init(forceResponse: NetworkResponse) {
        self.forceResponse = forceResponse
    }
    
    func request(parameters: [AnyHashable : Any], completion: @escaping (NetworkResponse) -> Void) {
        completion(forceResponse)
    }
}
