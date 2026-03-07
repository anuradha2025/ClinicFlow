//
//  FindDoctorView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct FindDoctorView: View {
    @StateObject private var vm = DoctorListViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    TextField("Search doctors, specialties...", text: $vm.searchText)
                }
                .padding(12)
                .background(Color.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top, 8)

                // Specialty Filter
                SpecialtyFilterBar(
                    specialties: vm.specialties,
                    selected: $vm.selectedSpecialty
                )

                // Doctor List
                ScrollView {
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
            .background(Color(.systemGray6))
            .navigationTitle("Find a Doctor")
        }
        .onAppear { vm.loadDoctors() }
    }
}
