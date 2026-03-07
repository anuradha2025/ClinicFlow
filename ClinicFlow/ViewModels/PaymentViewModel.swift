//
//  PaymentViewModel.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation
import Combine

@MainActor
class PaymentViewModel: ObservableObject {
    @Published var card = CardDetails()
    let billing: BillingInfo
    let doctor: Doctor

    init(billing: BillingInfo, doctor: Doctor) {
        self.billing = billing
        self.doctor = doctor
    }

    func processPayment(completion: @escaping () -> Void) {
        completion()
    }
}
