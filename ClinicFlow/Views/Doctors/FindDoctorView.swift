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
        .onAppear { vm.loadDoctors() }
        .onChange(of: appState.popToRoot) { oldValue, newValue in
            if newValue && appState.selectedTab == 0 {
                path = NavigationPath()
                appState.popToRoot = false
            }
        }
    }
}
