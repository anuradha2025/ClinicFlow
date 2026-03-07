//
//  Untitled.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation

enum AppointmentStatus: String, Codable {
    case upcoming, checkedIn, completed, cancelled, rescheduled
}

struct PrescriptionItem: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var dosage: String
}

struct LabTest: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
}

struct QueueEntry: Identifiable, Codable {
    let id: Int
    let time: String
    let status: QueueEntryStatus
}

enum QueueEntryStatus: String, Codable {
    case ongoing, new, cancelled, checkedIn

    var label: String {
        switch self {
        case .ongoing:   return "On Going"
        case .new:       return "New"
        case .cancelled: return "Cancelled"
        case .checkedIn: return "Checked In"
        }
    }

    var color: Color {
        switch self {
        case .ongoing:   return .cfPrimary
        case .new:       return .cfWarning
        case .cancelled: return .cfDanger
        case .checkedIn: return .cfSuccess
        }
    }
}

import SwiftUI
struct Appointment: Identifiable, Codable, Hashable {
    let id: UUID
    var doctor: Doctor
    var date: Date
    var time: String
    var status: AppointmentStatus
    var queueNumber: Int
    var estimatedWaitNumber: Int
    var prescription: [PrescriptionItem]
    var labTests: [LabTest]
    var queueEntries: [QueueEntry]

    static func == (lhs: Appointment, rhs: Appointment) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
