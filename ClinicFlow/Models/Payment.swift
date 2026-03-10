//
//  Payment.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation

struct BillingInfo: Codable {
    var doctorCharge: Double
    var hospitalFee: Double
    var total: Double
    var isPaid: Bool
}

struct CardDetails {
    var cardholderName: String = ""
    var cardNumber: String = ""
    var expiryMonth: String = ""
    var expiryYear: String = ""
    var cvv: String = ""
}
