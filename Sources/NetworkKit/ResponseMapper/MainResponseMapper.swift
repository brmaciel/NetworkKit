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
    open func map(_ response: Response) -> MappedModel? {
        #if DEBUG
        // If statement makes assertionFailure only run when is not running unit testing
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
            assertionFailure("This method must be overriden by its subclass")
        }
        #endif
        return nil
    }
}
