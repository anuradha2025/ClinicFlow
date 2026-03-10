//
//  NotificationItem.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-09.
//

import Foundation

enum NotificationType {
    case doctorArrived, doctorLate, nextUp, reminder, general

    var icon: String {
        switch self {
        case .doctorArrived: return "checkmark.circle.fill"
        case .doctorLate:    return "clock.badge.exclamationmark.fill"
        case .nextUp:        return "bell.badge.fill"
        case .reminder:      return "calendar.badge.clock"
        case .general:       return "info.circle.fill"
        }
    }

    var color: String {
        switch self {
        case .doctorArrived: return "success"
        case .doctorLate:    return "warning"
        case .nextUp:        return "primary"
        case .reminder:      return "primary"
        case .general:       return "secondary"
        }
    }
}

struct NotificationItem: Identifiable {
    let id = UUID()
    let type: NotificationType
    let title: String
    let message: String
    let time: String
    var isRead: Bool
}
