//
//  RequestDoubles.swift
//  NetworkKitTests
//
//  Created by Bruno Maciel on 1/9/22.
//

import Foundation
@testable import NetworkKit

class RequestDummy: RequestProtocol {
    var endpoint: String = ""
    var method: HTTPMethod = .get
    var header: [String : String] = [:]
    var body: Data? = nil
    var path: [(param: String, value: String)] = []
    var query: [(param: String, value: String)] = []
}
