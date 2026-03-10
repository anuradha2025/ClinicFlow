//
//  AppNavigation.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import Foundation
import Combine

class AppNavigation: ObservableObject {
    @Published var selectedTest: LabTest? = nil
    @Published var showBooking:  Bool     = false
    @Published var showPayment:  Bool     = false
    @Published var showSuccess:  Bool     = false
    @Published var bookedDate:   Date     = Date()
    @Published var bookedTime:   String   = "08:00 AM"
    @Published var selectedTab:  Int      = 0

    func reset() {
        selectedTest = nil
        showBooking  = false
        showPayment  = false
        showSuccess  = false
    }
}
