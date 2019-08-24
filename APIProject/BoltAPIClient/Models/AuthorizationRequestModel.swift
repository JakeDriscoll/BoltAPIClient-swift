//
//  AuthorizationRequestModel.swift
//  TestingProject
//
//  Created by Jakob Driscoll on 8/23/19.
//  Copyright © 2019 Jakob Driscoll. All rights reserved.
//

import Foundation
struct AuthRequest : Encodable {
    // Required fields
    let merchantID, hsn, amount: String
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
    
}
