//
//  ServiceProtocol.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

protocol ServiceProtocol {
    /**
     Make request to API.
     Returning in `success` closure an instance of the model
     
     - Parameters:
        - request: object that carries all information needed to be sent to service
        - mapResponseAction: method responsible for converting the `responseObj` into the model. It's recommended to use the `.map(_:)` method of a `ResponseMapper`
        - responseObj:object decoded from response data
        - success: success handler closure that return the model
        - model: instance of model that was created from the response in the `mapReseponAction`
        - failure: failure handler closure that indicates that creating the model has failed
        - response: instance of type NetworkResponse to be used in case is necessary to find out the reason of failure
     
     ~~~
     // Example
     makeRequest(request: ExampleRequest(),
                 mapResponseAction: ExampleMapper().map,
                 success: { model in },
                 failure: { response in })
     ~~~
     */
    func makeRequest<Response: Decodable, Model>(request: RequestProtocol,
                                                 mapResponseAction: @escaping (_ responseObj: Response) -> Model?,
                                                 success: @escaping (_ model: Model) -> Void,
                                                 failure: @escaping (_ response: NetworkResponse) -> Void)
    
    /**
     Make request to API.
     Returning in `success` closure an instance of the model and an instance of the response to access any other useful information, if needed
     
     - Parameters:
        - request: object that carries all information needed to be sent to service
        - mapResponseAction: method responsible for converting the `responseObj` into the model. It's recommended to use the `.map(_:)` method of a `ResponseMapper`
        - responseObj:object decoded from response data
        - success: success handler closure that is executed when an instance of model can be created from response
        - model: instance of model that was created from the response by the mapper
        - response: instance of type NetworkResponse to be used in case response has any other useful information
        - failure: failure handler closure that indicates that creating the model has failed
        - failResponse: instance of type NetworkResponse to be used in case is necessary to find out the reason of failure
     
     ~~~
     // Example
     makeRequest(request: ExampleRequest(),
                 mapResponseAction: ExampleMapper().map,
                 success: { (model, response) in },
                 failure: { response in })
     ~~~
     */
    func makeRequest<Response: Decodable, Model>(request: RequestProtocol,
                                                 mapResponseAction: @escaping (_ responseObj: Response) -> Model?,
                                                 success: @escaping (_ model: Model, _ response: NetworkResponse) -> Void,
                                                 failure: @escaping (_ failResponse: NetworkResponse) -> Void)
    
    /**
     Make request to API. Returning in `completion` closure an instance of the response.
     
     - Parameters:
        - request: object that carries all information needed to be sent to service
        - response: instance of type NetworkResponse to be used in case response has any other useful information
     */
    func makeRequest(request: RequestProtocol, completion: @escaping (_ response: NetworkResponse) -> Void)
}
