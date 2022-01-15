//
//  RestResponseRestResponse.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

struct RestResponse: NetworkResponse {
    var data: Data?
    var statusCode: Int
    var headers: [AnyHashable : Any]
    var result: NetworkResponseResult
}
