//
//  ContentView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var nav: AppNavigation
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            if let test = nav.selectedTest {
                if nav.showSuccess {
                    LabPaymentSuccessView(test: test)
                        .environmentObject(nav)
                        .environmentObject(appState)
                        .transition(.move(edge: .trailing))
                } else if nav.showPayment {
                    LabPaymentView(test: test)
                        .environmentObject(nav)
                        .transition(.move(edge: .trailing))
                } else if nav.showBooking {
                    BookingView(test: test)
                        .environmentObject(nav)
                        .transition(.move(edge: .trailing))
                } else {
                    TestDetailView(test: test)
                        .environmentObject(nav)
                        .transition(.move(edge: .trailing))
                }
            } else {
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
                .tint(.cfBlue)
                    .transition(.move(edge: .leading))
            }
        }
    }
}
