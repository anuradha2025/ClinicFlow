//
//  BookAppointmentViewModel.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation
import Combine

@MainActor
class BookAppointmentViewModel: ObservableObject {
    @Published var selectedDate: Date = Date()
    @Published var selectedTimeSlot: String? = nil
    @Published var availableSlots: [TimeSlot] = []
    @Published var billing: BillingInfo
    @Published var isBookingSuccess: Bool = false

    let doctor: Doctor

    init(doctor: Doctor) {
        self.doctor = doctor
        self.billing = BillingInfo(
            doctorCharge: doctor.chargeAmount,
            hospitalFee: 500,
            total: doctor.chargeAmount + 500,
            isPaid: false
        )
        loadSlots(for: Date())
    }

    func loadSlots(for date: Date) {
        // Mock data – replace with API
        availableSlots = [
            TimeSlot(time: "09:00 AM", availableCount: 11),
            TimeSlot(time: "12:00 PM", availableCount: 7),
            TimeSlot(time: "05:00 PM", availableCount: 3)
        ]
    }

    func bookAppointment() {
        // Call API here
        isBookingSuccess = true
    }
}

struct TimeSlot: Identifiable {
    let id = UUID()
    let time: String
    let availableCount: Int
}
