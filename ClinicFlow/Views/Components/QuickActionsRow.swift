//
//  QuickActionsRow.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct QuickActionsRow: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var nav: AppNavigation
    @State private var showProfile = false
    @State private var showMap = false

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                Button { appState.selectedTab = 1 } label: {
                    QuickActionItem(title: "Find Doctor", icon: "stethoscope", color: .cfPrimary)
                }
                Button { appState.selectedTab = 2 } label: {
                    QuickActionItem(title: "Appointments", icon: "calendar", color: .cfSuccess)
                }
                Button { appState.selectedTab = 3 } label: {
                    QuickActionItem(title: "Laboratory", icon: "cross.case.fill", color: .cfWarning)
                }
                Button { appState.selectedTab = 4 } label: {
                    QuickActionItem(title: "Pharmacy", icon: "pills.fill", color: .cfDanger)
                }
                Button { showProfile = true } label: {
                    QuickActionItem(title: "Profile", icon: "person.fill", color: .cfBlue)
                }
                Button { showMap = true } label: {
                    QuickActionItem(title: "Hospital Map", icon: "map.fill", color: .cfPurple)
                }
            }
            .padding(.horizontal, 16)
        }
        .sheet(isPresented: $showProfile) {
            ProfileView()
                .environmentObject(appState)
                .environmentObject(nav)
        }
        .sheet(isPresented: $showMap) {
            HospitalIndoorMapView()
        }
    }
}

struct QuickActionItem: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
                .frame(width: 56, height: 56)
                .background(color.opacity(0.1))
                .cornerRadius(16)
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundColor(.cfTextSecondary)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .frame(width: 60)
        }
    }
}
