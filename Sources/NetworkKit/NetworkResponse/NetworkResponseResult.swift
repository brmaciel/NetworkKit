//
//  NetworkResponseResult.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

public enum NetworkResponseResult {
    case success, failure(NetworkResponseError)
}
