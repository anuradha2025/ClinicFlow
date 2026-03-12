//
//  FindDoctorView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct FindDoctorView: View {
    @StateObject private var vm = DoctorListViewModel()
    @EnvironmentObject var appState: AppState
    @State private var path = NavigationPath()
    @State private var navigationKey = 0

    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .top) {

                Color.cfBg.ignoresSafeArea()

                VStack(spacing: 0) {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {
                            // Search Bar
                            CFSearchBar(text: $vm.searchText, placeholder: "Search doctors, specialties…")
                                .padding(.horizontal)
                                .padding(.top, 16)

                            // Specialty Filter
                            SpecialtyFilterBar(
                                specialties: vm.specialties,
                                selected: $vm.selectedSpecialty
                            )

                            // Doctor List
                            LazyVStack(spacing: 12) {
                                ForEach(vm.filteredDoctors) { doctor in
                                    NavigationLink(destination: DoctorProfileView(doctor: doctor)) {
                                        DoctorListRow(doctor: doctor) {
                                            vm.toggleFavorite(doctor)
                                        }
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.top, 12)
                            .padding(.bottom, 20)
                        }
                    }
                }
            }
            .navigationTitle("Find a Doctor")
        }
        .id(navigationKey)
        .onAppear { vm.loadDoctors() }
        .onChange(of: appState.popToRoot) { shouldPop in
            if shouldPop && appState.selectedTab == 0 {
                navigationKey += 1  // rotates the NavigationStack's id, clearing all pushed views
                appState.popToRoot = false
            }
        }
    }
}
