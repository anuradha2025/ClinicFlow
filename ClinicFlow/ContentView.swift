//
//  ContentView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView(selection: $appState.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }.tag(0)

            FindDoctorView()
                .tabItem {
                    Label("Doctors", systemImage: "stethoscope")
                }.tag(1)

            MyAppointmentsView()
                .tabItem {
                    Label("Appointments", systemImage: "calendar")
                }.tag(2)

            MyReportsView()
                .tabItem {
                    Label("Reports", systemImage: "doc.text.fill")
                }.tag(3)

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.fill")
                }.tag(4)
        }
        .accentColor(.cfPrimary)
    }
}
