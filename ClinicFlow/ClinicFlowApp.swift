//
//  ClinicFlowApp.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

@main
struct ClinicFlowApp: App {
    @StateObject private var appState = AppState()
    @StateObject private var nav = AppNavigation()
    @StateObject private var authVM = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(appState)
                .environmentObject(nav)
                .environmentObject(authVM)
        }
    }
}

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Group {
            if authVM.isLoggedIn {
                ContentView()
            } else {
                SplashView()
            }
        }
        .animation(.easeInOut, value: authVM.isLoggedIn)
    }
}
