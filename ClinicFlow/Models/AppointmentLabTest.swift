//
//  AppointmentLabTest.swift
//  ClinicFlow
//
//  Lightweight lab test model used inside Appointment history.
//

import Foundation

struct AppointmentLabTest: Identifiable, Codable, Hashable {
    let id:   UUID
    let name: String
}

