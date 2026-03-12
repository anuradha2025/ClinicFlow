//
//  MainTabView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var nav: AppNavigation
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            HomeView()
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)

            FindDoctorView()
                .tabItem { Label("Doctors", systemImage: "stethoscope") }
                .tag(1)

            MyAppointmentsView()
                .tabItem { Label("Appointments", systemImage: "calendar") }
                .tag(2)

            MyReportsView()
                .tabItem { Label("Reports", systemImage: "doc.text.fill") }
                .tag(3)

            LaboratoryView()
                .environmentObject(nav)
                .tabItem { Label("Laboratory", systemImage: "cross.case.fill") }
                .tag(4)
        }
        .accentColor(.cfBlue)
    }
}
