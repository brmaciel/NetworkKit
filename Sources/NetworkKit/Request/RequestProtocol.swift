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
    var header: [String: String] { get }
    var body: Data? { get }
    var path: [(param: String, value: String)] { get }
    var query: [(param: String, value: String)] { get }
}
