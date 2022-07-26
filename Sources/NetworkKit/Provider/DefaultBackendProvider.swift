//
//  DefaultBackendProvider.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

open class DefaultBackendProvider: BackendProvider {
    
    internal var apiRequester: ApiRequester? = DefaultApiRequester.shared
    public var successStatusCodeRange: ClosedRange<Int> = 200...299
    /**
     Base url string.
     
     Needs to be set by subclasses
     */
    public var baseURL: String
    
    // MARK: Contuctor
    public init(baseUrl: String) {
        self.baseURL = baseUrl
    }
    
    
    // MARK: - BackendProvider Protocol Methods
    
    /**
     Make request to API.
     Returning in `completion` closure an instance of the response.
     
     The `parameters` parameter is a `Dictionary<AnyHashable,Any>` and is expected to have the following keys:
        - header: with value of type `Dictionary<String,String>`
        - body: with value of type `Data`
        - method: with value of type `HTTPMethod`. If not informed, the defualt value is `.get`
        - endpoint: with value of type String
        - path: with value of type `Dictionary<AnyHashable,Any>`
        - query: with value of type `Dictionary<AnyHashable,Any>`
     
     - Parameters:
        - parameters: object that carries all parameters needed to be create request object
        - completion: completion handler closure that return the response object
     */
    open func request(parameters: [AnyHashable : Any], completion: @escaping (NetworkResponse) -> Void) {
        let headers = parameters["header"] as? [String : String]
        let body = parameters["body"] as? Data
        let method = (parameters["method"] as? HTTPMethod) ?? .get
        
        let resourcePath = buildResourcePath(endpoint: parameters["endpoint"] as? String,
                                             pathParameters: parameters["path"] as? [(String, String)],
                                             queryParameters: parameters["query"] as? [(String, String)])
        let url = buildRequestUrl(resourcePath: resourcePath)
        
        apiRequester?.request(url: url,
                              body: body,
                              method: method,
                              headers: headers,
                              successStatusCodeRange: successStatusCodeRange,
                              completion: completion)
    }
    
    // MARK: - Methods
    
    /**
     Builds path string from path parameters.
     
      - Returns: String in format `/param1/value1/param2/value2`
     */
    public func buildPathString(from pathParameters: [(param: String, value: String)]?) -> String? {
        guard
            let pathParams = pathParameters,
            !pathParams.isEmpty
            else { return nil }
        
        return String(pathParams
                        .reduce("/") { $0 + "\($1.param)/\($1.value)/" }
                        .dropLast())
    }
    
    /**
     Builds query string from query parameters.
     
      - Returns: String in format `?param1=value1&param2=value2`
     */
    public func buildQueryString(from queryParameters: [(param: String, value: String)]?) -> String? {
        guard
            let queryParams = queryParameters,
            !queryParams.isEmpty
            else { return nil }
        
        return String(queryParams
                        .reduce("?") { $0 + "\($1.param)=\($1.value)&" }
                        .dropLast())
    }
    
    /**
     Builds the resource path from the endpoint, path parameters and query parameters.
     
      - Returns: String in format `/endpoint/pathParam1/pathValue1/pathParam2/pathValue2?queryParam1=queryValue1&queryParam2=queryValue2`
     */
    public func buildResourcePath(endpoint: String?,
                                  pathParameters: [(String, String)]?,
                                  queryParameters: [(String, String)]?) -> String {
        var resourcePath = endpoint ?? ""
        
        if let pathParameters = buildPathString(from: pathParameters) {
            resourcePath.append(pathParameters)
        }
        if let queryParameters = buildQueryString(from: queryParameters) {
            resourcePath.append(queryParameters)
        }
        
        return resourcePath
    }
    
    /**
     Builds the request url combining the base url with the resource path.
     
     - Parameters:
       - resourcePath: String that represents the path, which contains the endpoint and parameters (path and query)
     */
    open func buildRequestUrl(resourcePath: String) -> URL? {
        let completePath = baseURL + (resourcePath.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? resourcePath)
        return URL(string: completePath)
    }
}
