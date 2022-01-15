//
//  ResponseMapper.swift
//  NetworkKit
//
//  Created by Bruno Maciel on 1/8/22.
//

import Foundation

public protocol ResponseMapper: AnyObject {
    associatedtype Response: Decodable
    associatedtype MappedModel
    
    func map(_ response: Response) -> MappedModel?
}
