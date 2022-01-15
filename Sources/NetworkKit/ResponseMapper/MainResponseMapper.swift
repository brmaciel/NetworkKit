//
//  MainResponseMapper.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

open class MainResponseMapper<Response: Decodable, MappedModel>: ResponseMapper {
    public init() {}
    
    /// Must be overriden by subclass
    open func map(_ response: Response) -> MappedModel? { return nil }
}
