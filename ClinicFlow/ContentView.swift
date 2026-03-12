//
//  ContentView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var nav: AppNavigation

    var body: some View {
        ZStack {
            if let test = nav.selectedTest {
                if nav.showSuccess {
                    LabPaymentSuccessView(test: test)
                        .environmentObject(nav)
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
                MainTabView()
                    .environmentObject(nav)
                    .transition(.move(edge: .leading))
            }
        }
    }
}
