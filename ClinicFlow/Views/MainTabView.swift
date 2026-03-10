//
//  MainTabView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var nav: AppNavigation

    var body: some View {
        TabView(selection: $nav.selectedTab) {
            LaboratoryView()
                .environmentObject(nav)
                .tabItem { Label("Laboratory", systemImage: "cross.case.fill") }
                .tag(0)

            MyReportsView()
                .environmentObject(nav)
                .tabItem { Label("My Reports", systemImage: "doc.text.fill") }
                .tag(1)
        }
        .accentColor(.cfBlue)
    }
}
