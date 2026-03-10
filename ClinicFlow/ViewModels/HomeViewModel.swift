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
        topDoctors = MockDataService.shared.doctors

        // Only show today's and future upcoming appointments
        upcomingAppointments = MockDataService.shared.appointments
            .filter { $0.status == .upcoming }
            .sorted { $0.date < $1.date }

        isLoading = false
    }
}
