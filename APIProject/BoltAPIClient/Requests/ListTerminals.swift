//
//  ListTerminals.swift
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation
public struct ListResponse : Decodable {
    public let terminals: [String]
}

public class ListTerminal : Encodable, APIRequest {
    
    public typealias Response = ListResponse


    public var resourceName: String {
        return "listTerminals"
    }

    let merchantId: String

    public init(merchantId: String) {
        self.merchantId = merchantId
    }
}
