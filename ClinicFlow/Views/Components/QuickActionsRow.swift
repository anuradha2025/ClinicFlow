//
//  QuickActionsRow.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct QuickActionsRow: View {
    var body: some View {
        HStack(spacing: 12) {
            NavigationLink(destination: FindDoctorView()) {
                QuickActionItem(title: "Find Doctor", icon: "stethoscope", color: .cfPrimary)
            }
            NavigationLink(destination: MyAppointmentsView()) {
                QuickActionItem(title: "Appointments", icon: "calendar", color: .cfSuccess)
            }
            NavigationLink(destination: MyReportsView()) {
                QuickActionItem(title: "Reports", icon: "doc.text", color: .cfWarning)
            }
            NavigationLink(destination: AccountView()) {
                QuickActionItem(title: "Settings", icon: "gearshape", color: .cfDanger)
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
                .frame(width: 50, height: 50)
                .background(color.opacity(0.1))
                .cornerRadius(12)
            Text(title)
                .font(.caption)
                .foregroundColor(.cfTextSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}
