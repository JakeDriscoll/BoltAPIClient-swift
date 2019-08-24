//
//  ListTerminals.swift
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation

public class ListTerminal : BaseRequest {
    public override var resourceName: String {
        return "listTerminals"
    }
    public override init(merchantID: String) {
        super.init(merchantID: merchantID)
    }
}
