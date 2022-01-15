//
//  ApiRequester.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/9/22.
//

import Foundation

protocol ApiRequester: AnyObject {
    func request(url providerURL: URL?,
                 body jsonData: Data?,
                 method: HTTPMethod,
                 headers: [String: String]?,
                 successStatusCodeRange: ClosedRange<Int>,
                 completion: @escaping (NetworkResponse) -> Void)
    
    func request(_ request: URLRequest,
                 successStatusCodeRange: ClosedRange<Int>,
                 completion: @escaping (NetworkResponse) -> Void)
}
