//
//  NetworkResponseDoubles.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import Foundation
@testable import NetworkKit

struct NetworkResponseGenerator {
    static var dummy = GenericNetworkResponse(data: "".data(using: .utf8),
                                              statusCode: 200,
                                              headers: [:],
                                              result: .success)
    static var successStub = GenericNetworkResponse(data: "{}".data(using: .utf8),
                                                    statusCode: 200,
                                                    headers: [:],
                                                    result: .success)
    static var failureStub = GenericNetworkResponse(data: "".data(using: .utf8),
                                                    statusCode: 400,
                                                    headers: [:],
                                                    result: .failure(.responseStatusCode(code: 400)))
}

struct GenericNetworkResponse: NetworkResponse {
    var data: Data?
    var statusCode: Int
    var headers: [AnyHashable : Any]
    var result: NetworkResponseResult
}
