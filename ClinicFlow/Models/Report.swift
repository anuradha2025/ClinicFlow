//
//  Report.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation

enum ReportType: String, Codable {
    case labResult, prescription, labReport
}

struct Report: Identifiable, Codable {
    let id: UUID
    var title: String
    var type: ReportType
    var date: Date
    var fileSize: String        // e.g. "2.4 MB"
    var fileURL: URL?
}
