//
//  NetworkResponseError.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

public enum NetworkResponseError: LocalizedError {
    case urlError
    case taskError(_ error: Error)
    case noResponse
    case responseStatusCode(code: Int)
    
    public var errorDescription: String? {
        switch self {
        case .urlError:
            return "Error while creating url"
        case .taskError(let error):
            return error.localizedDescription
        case .noResponse:
            return "Error while obtaining response"
        case .responseStatusCode(let statusCode):
            return "Request did fail with statusCode \(statusCode)"
        }
    }
}
