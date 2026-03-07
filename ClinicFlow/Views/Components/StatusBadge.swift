//
//  StatusBadge.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct StatusBadge: View {
    let status: AppointmentStatus

    var label: String {
        switch status {
        case .upcoming:    return "Today"
        case .checkedIn:   return "Checked In"
        case .completed:   return "Completed"
        case .cancelled:   return "Cancelled"
        case .rescheduled: return "Rescheduled"
        }
    }

    var color: Color {
        switch status {
        case .upcoming:    return .cfPrimary
        case .checkedIn:   return .cfSuccess
        case .completed:   return .cfTextSecondary
        case .cancelled:   return .cfDanger
        case .rescheduled: return .cfWarning
        }
    }

    var body: some View {
        Text(label)
            .font(.caption2.bold())
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(6)
    }
}
