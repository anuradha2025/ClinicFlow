//
//  MyAppointmentsView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct MyAppointmentsView: View {
    @State private var selectedTab = 0
    private let allAppointments = MockDataService.shared.appointments

    var upcomingAppointments: [Appointment] {
        allAppointments
            .filter { $0.status == .upcoming }
            .sorted { $0.date < $1.date }
    }

    var previousAppointments: [Appointment] {
        allAppointments
            .filter { $0.status == .completed || $0.status == .cancelled }
            .sorted { $0.date > $1.date }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // Apple-style Segmented Picker
                HStack(spacing: 4) {
                    AppointmentTabPill(
                        title: "Upcoming",
                        count: upcomingAppointments.count,
                        isSelected: selectedTab == 0
                    ) { selectedTab = 0 }

                    AppointmentTabPill(
                        title: "Previous",
                        count: previousAppointments.count,
                        isSelected: selectedTab == 1
                    ) { selectedTab = 1 }
                }
                .padding(4)
                .background(Color(.systemGray5))
                .cornerRadius(14)
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 16)

                ScrollView {
                    LazyVStack(spacing: 14) {
                        if selectedTab == 0 {
                            appointmentList(
                                upcomingAppointments,
                                emptyIcon: "calendar.badge.clock",
                                emptyMessage: "No upcoming appointments",
                                emptySubtitle: "Book an appointment with a doctor"
                            )
                        } else {
                            appointmentList(
                                previousAppointments,
                                emptyIcon: "clock.arrow.circlepath",
                                emptyMessage: "No previous appointments",
                                emptySubtitle: "Your completed appointments will appear here"
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 24)
                }
            }
            .background(Color(.systemGray6))
            .navigationTitle("My Appointments")
        }
    }

    @ViewBuilder
    func appointmentList(_ list: [Appointment],
                         emptyIcon: String,
                         emptyMessage: String,
                         emptySubtitle: String) -> some View {
        if list.isEmpty {
            VStack(spacing: 14) {
                Image(systemName: emptyIcon)
                    .font(.system(size: 52))
                    .foregroundColor(.cfPrimary.opacity(0.3))
                Text(emptyMessage)
                    .font(.headline)
                    .foregroundColor(.cfTextPrimary)
                Text(emptySubtitle)
                    .font(.subheadline)
                    .foregroundColor(.cfTextSecondary)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 80)
        } else {
            ForEach(list) { appointment in
                ImprovedAppointmentCard(appointment: appointment)
            }
        }
    }

    @ViewBuilder
    func destinationView(for appointment: Appointment) -> some View {
        if Calendar.current.isDateInToday(appointment.date) {
            TodayAppointmentDetailView(appointment: appointment)
        } else if appointment.status == .upcoming {
            UpcomingAppointmentDetailView(appointment: appointment)
        } else {
            PreviousAppointmentDetailView(appointment: appointment)
        }
    }
}

