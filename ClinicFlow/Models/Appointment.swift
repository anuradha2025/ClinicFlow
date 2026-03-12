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

struct QueueEntry: Identifiable, Codable {
    let id: Int
    let time: String
    let status: QueueEntryStatus
}

enum QueueEntryStatus: String, Codable {
    case finished, checkedIn, cancelled, ongoing, you

    var label: String {
        switch self {
        case .finished:  return "Finished"
        case .checkedIn: return "Checked In"
        case .cancelled: return "Cancelled"
        case .ongoing:   return "On Going"
        case .you:       return "You"
        }
    }

    var color: Color {
        switch self {
        case .finished:  return .cfTextSecondary
        case .checkedIn: return .cfSuccess
        case .cancelled: return .cfDanger
        case .ongoing:   return .cfPrimary
        case .you:       return .cfWarning
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
    var labTests: [AppointmentLabTest]
    var queueEntries: [QueueEntry]

    static func == (lhs: Appointment, rhs: Appointment) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }
}
