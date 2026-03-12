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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .environmentObject(nav)
        }
    }
}
