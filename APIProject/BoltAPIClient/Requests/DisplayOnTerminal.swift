//
//  DisplayOnTerminal.swift
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation

public class DisplayOnTerminal : BaseRequest {
    public override var resourceName: String {
        return "ping"
    }

    private let hsn: String
    private let text: String

    init(merchantID: String, terminalID: String, displayText: String)
    {
        self.hsn = terminalID
        self.text = displayText
        super.init(merchantID: merchantID)
    }
}
