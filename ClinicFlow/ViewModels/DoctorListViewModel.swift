//
//  DoctorListViewModel.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation
import Combine

@MainActor
class DoctorListViewModel: ObservableObject {
    @Published var doctors: [Doctor] = []
    @Published var searchText: String = ""
    @Published var selectedSpecialty: String = "All"

    let specialties = ["All", "Cardiologist", "Paediatrician", "Neurologist",
                       "Dermatologist", "Gynaecologist", "Orthopaedic",
                       "Psychiatrist", "Ophthalmologist"]

    var filteredDoctors: [Doctor] {
        doctors.filter { doctor in
            (selectedSpecialty == "All" || doctor.specialty == selectedSpecialty) &&
            (searchText.isEmpty || doctor.name.localizedCaseInsensitiveContains(searchText))
        }
    }

    func loadDoctors() {
        doctors = MockDataService.shared.doctors
    }

    func toggleFavorite(_ doctor: Doctor) {
        if let index = doctors.firstIndex(where: { $0.id == doctor.id }) {
            doctors[index].isFavorite.toggle()
        }
    }
}
