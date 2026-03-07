//
//  HomeView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @State private var navigateToFindDoctor = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hello \(vm.userName)! 👋")
                                .font(.title2.bold())
                                .foregroundColor(.cfTextPrimary)
                            Text("How are you feeling today?")
                                .font(.subheadline)
                                .foregroundColor(.cfTextSecondary)
                        }
                        Spacer()
                        Button { } label: {
                            Image(systemName: "bell")
                                .font(.title3)
                                .foregroundColor(.cfTextPrimary)
                        }
                    }
                    .padding(.horizontal)

                    // Quick Actions
                    QuickActionsRow()

                    // Upcoming Appointments
                    SectionHeader(title: "Upcoming Appointments", actionTitle: "See All") { }

                    if vm.upcomingAppointments.isEmpty {
                        Text("No upcoming appointments")
                            .foregroundColor(.cfTextSecondary)
                            .padding(.horizontal)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(vm.upcomingAppointments) { appt in
                                    NavigationLink(value: appt) {
                                        UpcomingAppointmentCard(appointment: appt)
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Top Doctors
                    SectionHeader(title: "Top Doctors", actionTitle: "See All") {
                        navigateToFindDoctor = true
                    }

                    ForEach(vm.topDoctors.prefix(3)) { doctor in
                        NavigationLink(value: doctor) {
                            TopDoctorCard(doctor: doctor)
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
            }
            .background(Color.cfBackground)
            .navigationDestination(for: Doctor.self) { doctor in
                DoctorProfileView(doctor: doctor)
            }
            .navigationDestination(for: Appointment.self) { appt in
                AppointmentDetailView(appointment: appt)
            }
        }
        .onAppear { vm.loadData() }
    }
}
