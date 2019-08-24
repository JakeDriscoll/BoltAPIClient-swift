//
//  APIRequest.swift
//  TestingProject
//
//  Created by Jakob Driscoll on 8/22/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation

public protocol APIRequest: Encodable {
    /// Response (will be wrapped with a DataContainer)
    associatedtype Response: Decodable
    
    /// Endpoint for this request (the last part of the URL)
    var resourceName: String { get }
}
