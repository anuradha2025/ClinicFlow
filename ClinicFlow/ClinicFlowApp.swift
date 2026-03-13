//
//  ClinicFlowApp.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

@main
struct ClinicFlowApp: App {
    @StateObject private var authVM = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
        }
    }
}

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Group {
            if authVM.isLoggedIn {
                NavigationStack {
                    AppointmentView()
                }
            } else {
                SplashView()
            }
        }
        .animation(.easeInOut, value: authVM.isLoggedIn)
    }
}
