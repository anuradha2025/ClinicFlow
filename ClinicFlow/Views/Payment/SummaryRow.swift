//
//  SummaryRow.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//


import SwiftUI
// MARK: - Summary Row
struct LabSummaryRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label).font(.system(size: 13)).foregroundColor(.cfTextSecondary)
            Spacer()
            Text(value).font(.system(size: 13, weight: .medium)).foregroundColor(.cfTextPrimary)
        }
    }
}
