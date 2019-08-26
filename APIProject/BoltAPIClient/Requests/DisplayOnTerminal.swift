//
//  DisplayOnTerminal.swift
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation

public class DisplayOnTerminal : Encodable, APIRequest {
    public typealias Response = [String:String]
    public var resourceName: String {
        return "listTerminals"
    }

    let merchantId, hsn, text: String

    init(merchantId: String, terminalID: String, displayText: String)
    {
        self.hsn = terminalID
        self.text = displayText
        self.merchantId = merchantId
    }
}
