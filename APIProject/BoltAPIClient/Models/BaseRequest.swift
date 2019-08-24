//
//  AuthorizeCard.swift
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation

public class BaseRequest : Encodable, APIRequest {
    public typealias Response = [String:String]
    public var resourceName: String {
        return "nil"
    }
    private let merchantId: String

    public init(merchantID: String)
    {
        self.merchantId = merchantID
    }
}
