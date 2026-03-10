//
//  ReportsViewModel.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation
import Combine

@MainActor
class ReportsViewModel: ObservableObject {
    @Published var reports: [Report] = []
    @Published var searchText: String = ""
    @Published var selectedFilter: ReportType? = nil

    var filteredReports: [Report] {
        reports.filter { report in
            let matchesFilter = selectedFilter == nil || report.type == selectedFilter
            let matchesSearch = searchText.isEmpty ||
                report.title.localizedCaseInsensitiveContains(searchText) ||
                report.doctorName.localizedCaseInsensitiveContains(searchText)
            return matchesFilter && matchesSearch
        }
    }

    // Group reports by month
    var groupedReports: [(key: String, value: [Report])] {
        let grouped = Dictionary(grouping: filteredReports) { report in
            report.date.formatted(.dateTime.month(.wide).year())
        }
        return grouped.sorted { a, b in
            let dateA = filteredReports.first { $0.date.formatted(.dateTime.month(.wide).year()) == a.key }?.date ?? Date()
            let dateB = filteredReports.first { $0.date.formatted(.dateTime.month(.wide).year()) == b.key }?.date ?? Date()
            return dateA > dateB
        }
    }

    func loadReports() {
        reports = MockDataService.shared.reports
    }
}
