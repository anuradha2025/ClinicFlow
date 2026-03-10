//
//  MyReportsView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

struct MyReportsView: View {
    @State private var searchText = ""

    var filtered: [TestReport] {
        if searchText.isEmpty { return sampleReports }
        return sampleReports.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.subtitle.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.cfBg.ignoresSafeArea()

                VStack(spacing: 0) {
                    ScreenHeader(title: "My Reports")

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {

                            // ── Search ────────────────────────────────
                            CFSearchBar(text: $searchText, placeholder: "Search reports…")
                                .padding(.horizontal, 16)
                                .padding(.top, 16)

                            // ── Stats ─────────────────────────────────
                            HStack(spacing: 12) {
                                ReportStat(value: "\(sampleReports.count)",
                                           label: "Total Reports",
                                           icon: "doc.fill",
                                           color: .cfBlue)
                                ReportStat(value: "\(sampleReports.filter { $0.isNew }.count)",
                                           label: "New This Month",
                                           icon: "sparkles",
                                           color: .cfSuccess)
                                ReportStat(value: "3",
                                           label: "Pending",
                                           icon: "clock.fill",
                                           color: .cfWarning)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 14)

                            // ── List ──────────────────────────────────
                            LazyVStack(spacing: 10) {
                                if filtered.isEmpty {
                    EmptyStateView(message: "No reports matching: " + searchText)
                                        .padding(.top, 40)
                                } else {
                                    ForEach(filtered) { report in
                                        ReportCard(report: report)
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .padding(.bottom, 30)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
    }
}

