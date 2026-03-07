//
//  ReportsViewModel.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation
import Combine

enum ReportFilter: String, CaseIterable {
    case all = "All Results"
    case lab = "Lab Results"
    case prescription = "Prescriptions"
}

@MainActor
class ReportsViewModel: ObservableObject {
    @Published var reports: [Report] = []
    @Published var selectedFilter: ReportFilter = .all

    var filteredReports: [Report] {
        switch selectedFilter {
        case .all:          return reports
        case .lab:          return reports.filter { $0.type == .labResult }
        case .prescription: return reports.filter { $0.type == .prescription }
        }
    }

    func loadReports() {
        reports = MockDataService.shared.reports
    }
}
