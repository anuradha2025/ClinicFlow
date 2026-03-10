//
//  Report.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation

enum ReportType: String, Codable, CaseIterable {
    case labResult      = "Lab Result"
    case prescription   = "Prescription"
    case observation    = "Observation"
    case imaging        = "Imaging"
    case discharge      = "Discharge Summary"

    var icon: String {
        switch self {
        case .labResult:    return "testtube.2"
        case .prescription: return "pills.fill"
        case .observation:  return "doc.text.fill"
        case .imaging:      return "waveform.path.ecg"
        case .discharge:    return "clipboard.fill"
        }
    }

    var color: String {
        switch self {
        case .labResult:    return "primary"
        case .prescription: return "success"
        case .observation:  return "warning"
        case .imaging:      return "purple"
        case .discharge:    return "secondary"
        }
    }
}

struct Report: Identifiable, Codable {
    let id: UUID
    var title: String
    var type: ReportType
    var date: Date
    var fileSize: String
    var doctorName: String
    var fileURL: URL?
}
