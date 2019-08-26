//
//  DisconnectTerminal.swift
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation

public class DisconnectTerminal : Encodable, APIRequest {
    public typealias Response = [String:String]
    public var resourceName: String {
        return "disconnect"
    }
    
    let merchantId, hsn: String

    init(merchantId: String, terminalID: String)
    {
        self.hsn = terminalID
        self.merchantId = merchantId
    }
}
