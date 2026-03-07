//
//  QueueStatusPill.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct QueueStatusPill: View {
    let status: QueueEntryStatus

    var body: some View {
        Text(status.label)
            .font(.caption2.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(status.color.opacity(0.15))
            .foregroundColor(status.color)
            .cornerRadius(20)
    }
}
