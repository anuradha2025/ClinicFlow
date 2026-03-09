//
//  QuickActionsRow.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct QuickActionsRow: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack(spacing: 12) {
            // Find Doctor → switches to Doctors tab
            Button {
                appState.selectedTab = 1
            } label: {
                QuickActionItem(title: "Find Doctor",
                                icon: "stethoscope",
                                color: .cfPrimary)
            }

            // Appointments → switches to Appointments tab
            Button {
                appState.selectedTab = 2
            } label: {
                QuickActionItem(title: "Appointments",
                                icon: "calendar",
                                color: .cfSuccess)
            }

            // Reports → switches to Reports tab
            Button {
                appState.selectedTab = 3
            } label: {
                QuickActionItem(title: "Reports",
                                icon: "doc.text",
                                color: .cfWarning)
            }

            // Settings → switches to Account tab
            Button {
                appState.selectedTab = 4
            } label: {
                QuickActionItem(title: "Settings",
                                icon: "gearshape",
                                color: .cfDanger)
            }
        }
        .padding(.horizontal)
    }
}

struct QuickActionItem: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 56, height: 56)
                .background(color.opacity(0.1))
                .cornerRadius(16)
            Text(title)
                .font(.caption)
                .foregroundColor(.cfTextSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}
