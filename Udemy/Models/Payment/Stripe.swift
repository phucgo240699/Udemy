//
//  Stripe.swift
//  Udemy
//
//  Created by Phúc Lý on 26/12/2020.
//  Copyright © 2020 Phúc Lý. All rights reserved.
//

import Foundation

struct CardStripeRequest: Codable {
    var number: Int?
    var exp_month: Int?
    var exp_year: Int?
    var cvc: Int?
}

struct CardStripeResponse: Codable {
    var id: String?
    var object: String?
    var address_city: String?
    var address_country: String?
    var address_line1: String?
    var address_line1_check: String?
    var address_line2: String?
    var address_state: String?
    var address_zip: String?
    var address_zip_check: String?
    var brand: String?
    var country: String?
    var cvc_check: String?
    var dynamic_last4: String?
    var exp_month: Int?
    var exp_year: Int?
    var fingerprint: String?
    var funding: String?
    var last4: String?
    var name: String?
    var tokenization_method: String?
}

struct StripeResponse: Codable {
    var id: String?
    var object: String?
    var card: CardStripeResponse?
    var client_ip: String?
    var created: Int?
    var livemode: Bool?
    var type: String?
    var used: Bool?
}
