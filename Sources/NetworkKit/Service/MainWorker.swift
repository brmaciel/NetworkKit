//
//  MainWorker.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

open class MainWorker {
    let backendProvider: BackendProvider
    
    // MARK: Constructor
    public init(provider: BackendProvider) {
        self.backendProvider = provider
    }
    
}

extension MainWorker: ServiceProtocol {
    public final func makeRequest<Response, Model>(request: RequestProtocol,
                                                   mapResponseAction: @escaping (_ responseObj: Response) -> Model?,
                                                   success: @escaping (_ model: Model) -> Void,
                                                   failure: @escaping (_ response: NetworkResponse) -> Void) where Response: Decodable {
        makeRequest(request: request,
                    mapResponseAction: mapResponseAction,
                    success: { (model, _) in success(model) },
                    failure: failure)
    }
    
    public final func makeRequest<Response, Model>(request: RequestProtocol,
                                                   mapResponseAction: @escaping (_ responseObj: Response) -> Model?,
                                                   success: @escaping (_ model: Model, _ response: NetworkResponse) -> Void,
                                                   failure: @escaping (_ failResponse: NetworkResponse) -> Void) where Response: Decodable {
        makeRequest(request: request) { response in
            switch response.result {
                case .success:
                    guard
                        let data = response.data,
                        let object = try? JSONDecoder().decode(Response.self, from: data),
                        let model = mapResponseAction(object)
                        else { failure(response); return }

                    success(model, response)

                case .failure(_):
                    failure(response);
            }
        }
    }
    
    public final func makeRequest(request: RequestProtocol, completion: @escaping (NetworkResponse) -> Void) {
        let parameters: [AnyHashable: Any] = [
            "header"   : request.header,
            "body"     : request.body,
            "path"     : request.path,
            "query"    : request.query,
            "endpoint" : request.endpoint,
            "method"   : request.method
        ]
        
        backendProvider.request(parameters: parameters, completion: completion)
    }
    
}
