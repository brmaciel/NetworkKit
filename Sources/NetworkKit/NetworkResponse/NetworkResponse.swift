//
//  NetworkResponse.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

public protocol NetworkResponse {
    var data: Data? { get }
    var statusCode: Int { get }
    var headers: [AnyHashable : Any] { get }
    var result: NetworkResponseResult { get }
}
