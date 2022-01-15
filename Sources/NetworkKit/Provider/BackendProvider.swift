//
//  BackendProvider.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

public protocol BackendProvider {
    /**
     Make request to API.
     Returning in `completion` closure an instance of the response.
     
     - Parameters:
        - parameters: object that carries all parameters needed to be create request object
        - completion: completion handler closure that return the response object
     */
    func request(parameters: [AnyHashable: Any],
                 completion: @escaping (_ response: NetworkResponse) -> Void)
}
