//
//  HomeViewModel.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var userName: String = "Sarah"
    @Published var upcomingAppointments: [Appointment] = []
    @Published var topDoctors: [Doctor] = []
    @Published var isLoading: Bool = false

    func loadData() {
        isLoading = true
        // Replace with real API call
        upcomingAppointments = MockDataService.shared.appointments
        topDoctors = MockDataService.shared.doctors
        isLoading = false
    }
}
