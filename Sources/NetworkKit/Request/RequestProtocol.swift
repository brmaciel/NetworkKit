//
//  RequestProtocol.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

public protocol RequestProtocol {
    var endpoint: String { get }
    var method: HTTPMethod { get }
    var header: [AnyHashable : Any] { get }
    var body: Data? { get }
    var path: [AnyHashable : Any] { get }
    var query: [AnyHashable : Any] { get }
}
