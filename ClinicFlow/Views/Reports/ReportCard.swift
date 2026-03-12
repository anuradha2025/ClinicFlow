//
//  ReportCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI
// MARK: - Report Card
struct ReportCard: View {
    let report: TestReport
    @State private var downloaded = false

    var body: some View {
        HStack(spacing: 14) {
            // PDF icon
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.cfDanger.opacity(0.10))
                    .frame(width: 54, height: 60)
                VStack(spacing: 3) {
                    Image(systemName: "doc.fill")
                        .font(.system(size: 22))
                        .foregroundColor(.cfDanger)
                    Text("PDF")
                        .font(.system(size: 9, weight: .bold))
                        .foregroundColor(.cfDanger)
                }
            }

            // Info
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(report.title)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.cfTextPrimary)
                    if report.isNew {
                        TagPill(text: "New", color: .cfSuccess, filled: true)
                    }
                }
                Text(report.subtitle)
                    .font(.system(size: 12))
                    .foregroundColor(.cfTextSecondary)
                HStack(spacing: 6) {
                    Image(systemName: "calendar").font(.system(size: 10))
                    Text(report.date).font(.system(size: 11))
                    Text("·")
                    Text(report.size).font(.system(size: 11))
                }
                .foregroundColor(.cfTextTertiary)
            }

            Spacer()

            // Download button
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    downloaded = true
                }
            } label: {
                ZStack {
                    Circle()
                        .fill(downloaded ? Color.cfSuccess.opacity(0.12) : Color.cfBlueLight)
                        .frame(width: 38, height: 38)
                    Image(systemName: downloaded ? "checkmark" : "arrow.down")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(downloaded ? .cfSuccess : .cfBlue)
                }
            }
        }
        .padding(14)
        .background(Color.cfCard)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 7, x: 0, y: 3)
    }
}
