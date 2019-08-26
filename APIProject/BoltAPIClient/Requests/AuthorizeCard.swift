//
//  AuthorizeCard.swift
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation

public struct AuthorizeCardResponse : Decodable {
    let token: String?
    let expiry: String?
    let name: String?
    let batchid: String?
    let retref: String?
    let avsresp: String?
    let respproc: String?
    let amount: String?
    let resptext: String?
    let authcode: String?
    let respcode: String?
    let merchid: String?
    let cvvresp: String?
    let respstat: String?
    let emvTagData: String?
    let tokenExpired: Bool?
    let errorCode: Int?
    let errorMessage: String?
}

public class AuthorizeCard : Encodable, APIRequest {
    
    public typealias Response = AuthorizeCardResponse
    public var resourceName: String {
        return "authCard"
    }
    // Required fields
    let merchantId, hsn, amount: String
    // Optional Fields
    // Strings
    let authMerchantId: String? = nil
    let orderID: String? = nil
    let signatureImageType: String? = nil
    let aid: String? = nil
    
    // Bools
    let createProfile: Bool? = nil
    let capture: Bool? = nil
    let includeCVV: Bool? = nil
    let includeAVS: Bool? = nil
    let beep: Bool? = nil
    let confirmAmount: Bool? = nil
    let includeAmountDisplay: Bool? = nil
    let gzipSignature: Bool? = nil
    let includeSignature: Bool? = nil
    let userFields: [String:String]? = nil
    // Time to clear display in milliseconds
    let clearDisplayDelay: Int? = nil

    init(merchantId: String, terminalID: String, amount: String)
    {
        self.hsn = terminalID
        self.merchantId = merchantId
        self.amount = amount
    }
    

}
