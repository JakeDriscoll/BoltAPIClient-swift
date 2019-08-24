//
//  DisconnectTerminal.swift
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation

public class DisconnectTerminal : BaseRequest {
    public override var resourceName: String {
        return "disconnect"
    }
    
    private let hsn: String

    init(merchantID: String, terminalID: String)
    {
        self.hsn = terminalID
        super.init(merchantID: merchantID)
    }
}
