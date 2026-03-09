//
//  MyReportsView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct MyReportsView: View {
    @StateObject private var vm = ReportsViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search reports or doctors...", text: $vm.searchText)
                }
                .padding(12)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 4)

                // Filter Chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ReportFilterChip(
                            title: "All",
                            isSelected: vm.selectedFilter == nil
                        ) {
                            vm.selectedFilter = nil
                        }
                        ForEach(ReportType.allCases, id: \.self) { type in
                            ReportFilterChip(
                                title: type.rawValue,
                                isSelected: vm.selectedFilter == type
                            ) {
                                vm.selectedFilter = vm.selectedFilter == type ? nil : type
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                }

                Divider()

                if vm.filteredReports.isEmpty {
                    VStack(spacing: 14) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 52))
                            .foregroundColor(.cfPrimary.opacity(0.3))
                        Text("No reports found")
                            .font(.headline)
                            .foregroundColor(.cfTextPrimary)
                        Text("Try a different search or filter")
                            .font(.subheadline)
                            .foregroundColor(.cfTextSecondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(alignment: .leading, spacing: 0, pinnedViews: [.sectionHeaders]) {
                            ForEach(vm.groupedReports, id: \.key) { group in
                                Section {
                                    VStack(spacing: 10) {
                                        ForEach(group.value) { report in
                                            ReportCard(report: report)
                                        }
                                    }
                                    .padding(.horizontal)
                                    .padding(.bottom, 16)
                                } header: {
                                    Text(group.key)
                                        .font(.subheadline.bold())
                                        .foregroundColor(.cfTextSecondary)
                                        .padding(.horizontal)
                                        .padding(.vertical, 8)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .background(Color(.systemGray6))
                                }
                            }
                        }
                        .padding(.bottom, 24)
                    }
                }
            }
            .background(Color(.systemGray6))
            .navigationTitle("My Reports")
            .onAppear { vm.loadReports() }
        }
    }
}

// MARK: - Filter Chip
struct ReportFilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.caption.bold())
                .foregroundColor(isSelected ? .white : .cfTextSecondary)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background(isSelected ? Color.cfPrimary : Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.cfPrimary : Color.gray.opacity(0.2), lineWidth: 1)
                )
        }
    }
}

// MARK: - Report Card
struct ReportCard: View {
    let report: Report
    @State private var showDetail = false

    var iconColor: Color {
        switch report.type {
        case .labResult:    return .cfPrimary
        case .prescription: return .cfSuccess
        case .observation:  return .cfWarning
        case .imaging:      return Color(hex: "#8B5CF6")
        case .discharge:    return .cfTextSecondary
        }
    }

    var body: some View {
        Button {
            showDetail = true
        } label: {
            HStack(spacing: 14) {

                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(iconColor.opacity(0.12))
                        .frame(width: 48, height: 48)
                    Image(systemName: report.type.icon)
                        .foregroundColor(iconColor)
                        .font(.system(size: 20))
                }

                // Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(report.title)
                        .font(.subheadline.bold())
                        .foregroundColor(.cfTextPrimary)
                        .lineLimit(1)
                    Text(report.doctorName)
                        .font(.caption)
                        .foregroundColor(.cfTextSecondary)
                    HStack(spacing: 6) {
                        Text(report.type.rawValue)
                            .font(.caption2.bold())
                            .foregroundColor(iconColor)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 3)
                            .background(iconColor.opacity(0.1))
                            .cornerRadius(6)
                        Text("•")
                            .foregroundColor(.cfTextSecondary)
                            .font(.caption2)
                        Text(report.fileSize)
                            .font(.caption2)
                            .foregroundColor(.cfTextSecondary)
                    }
                }

                Spacer()

                // Date + Download
                VStack(alignment: .trailing, spacing: 8) {
                    Text(report.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption2)
                        .foregroundColor(.cfTextSecondary)

                    Image(systemName: "arrow.down.circle.fill")
                        .font(.title2)
                        .foregroundColor(.cfPrimary.opacity(0.7))
                }
            }
            .padding(14)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showDetail) {
            ReportDetailSheet(report: report, iconColor: iconColor)
                .presentationDetents([.fraction(0.75), .large])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Report Detail Sheet
struct ReportDetailSheet: View {
    let report: Report
    let iconColor: Color
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {

            // Icon — add top padding since we removed the capsule
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(iconColor.opacity(0.12))
                    .frame(width: 72, height: 72)
                Image(systemName: report.type.icon)
                    .foregroundColor(iconColor)
                    .font(.system(size: 30))
            }
            .padding(.top, 24)   // ← add this
            .padding(.bottom, 16)

            Text(report.title)
                .font(.title3.bold())
                .foregroundColor(.cfTextPrimary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text(report.type.rawValue)
                .font(.subheadline)
                .foregroundColor(iconColor)
                .padding(.top, 4)

            // Details Card
            VStack(spacing: 0) {
                DetailRow(label: "Doctor", value: report.doctorName)
                Divider().padding(.horizontal)
                DetailRow(label: "Date",
                          value: report.date.formatted(date: .long, time: .omitted))
                Divider().padding(.horizontal)
                DetailRow(label: "File Size", value: report.fileSize)
                Divider().padding(.horizontal)
                DetailRow(label: "Format", value: "PDF Document")
            }
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.05), radius: 8)
            .padding(.horizontal)
            .padding(.top, 24)

            Spacer()

            // Action Buttons
            VStack(spacing: 10) {
                Button {
                    // Download logic
                } label: {
                    Label("Download Report", systemImage: "arrow.down.circle.fill")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.cfPrimary)
                        .cornerRadius(12)
                }

                Button {
                    // Share logic
                } label: {
                    Label("Share Report", systemImage: "square.and.arrow.up")
                        .fontWeight(.semibold)
                        .foregroundColor(.cfPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .overlay(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.cfPrimary, lineWidth: 1.5))
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 32)
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
    }
}

// MARK: - Detail Row
struct DetailRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.cfTextSecondary)
            Spacer()
            Text(value)
                .font(.subheadline.bold())
                .foregroundColor(.cfTextPrimary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}
