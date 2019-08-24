//
//  AuthorizeCard.swift
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation

public class AuthorizeCard : BaseRequest {
    public override var resourceName: String {
        return "authCard"
    }
    private let payload: AuthRequest

    init(merchantID: String, terminalID: String, amount: String)
    {
        self.payload = AuthRequest(merchantID: merchantID, hsn: terminalID, amount: amount)
        super.init(merchantID: merchantID)
    }
    

}
