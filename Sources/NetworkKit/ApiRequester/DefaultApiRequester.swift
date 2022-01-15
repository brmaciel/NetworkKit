//
//  DefaultApiRequester.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

public class DefaultApiRequester: ApiRequester {
    public static let shared = DefaultApiRequester()
    internal init() {}
    
    var urlSession: URLSession = URLSession.shared
    
    
    // MARK: - Metodos de Acesso a API
    
    public func request(url providerURL: URL?,
                        body jsonData: Data?,
                        method: HTTPMethod,
                        headers: [String: String]?,
                        successStatusCodeRange: ClosedRange<Int> = 200...299,
                        completion: @escaping (NetworkResponse) -> Void) {
        
        // Create Url
        guard let url = providerURL else {
            completion(RestResponse(data: nil, statusCode: 0, headers: [:], result: .failure(.urlError)))
            return }
        
        // Create Request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let body = jsonData { urlRequest.httpBody = body }
        if let header = headers { urlRequest.allHTTPHeaderFields = header }
        
        // Make Request
        request(urlRequest, successStatusCodeRange: successStatusCodeRange, completion: completion)
    }
    
    public func request(_ request: URLRequest,
                        successStatusCodeRange: ClosedRange<Int> = 200...299,
                        completion: @escaping (NetworkResponse) -> Void) {
        
        var response = RestResponse(data: nil, statusCode: 0, headers: [:], result: .success)
        
        // Create Task
        let dataTask = urlSession.dataTask(with: request) { (responseData: Data?, urlResponse: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                // DataTask Error
                if let error = error {
                    response.result = .failure(.taskError(error))
                    completion(response)
                    return }
                
                // No-Response Error
                guard let httpResponse = urlResponse as? HTTPURLResponse else {
                    response.result = .failure(.noResponse)
                    completion(response)
                    return }
                
                response.data = responseData
                response.statusCode = httpResponse.statusCode
                response.headers = httpResponse.allHeaderFields
                
                response.result = successStatusCodeRange.contains(response.statusCode)
                    ? .success
                    : .failure(.responseStatusCode(code: response.statusCode))
                
                completion(response)
            }
        }
        dataTask.resume()
    }
    
}
