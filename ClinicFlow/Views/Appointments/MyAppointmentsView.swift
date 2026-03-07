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

    var todayAppointments: [Appointment] {
        allAppointments.filter {
            $0.status == .upcoming &&
            Calendar.current.isDateInToday($0.date)
        }
    }

    var upcomingAppointments: [Appointment] {
        allAppointments.filter {
            $0.status == .upcoming &&
            !Calendar.current.isDateInToday($0.date)
        }
    }

    var previousAppointments: [Appointment] {
        allAppointments.filter {
            $0.status == .completed || $0.status == .cancelled
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Picker("", selection: $selectedTab) {
                    Text("Today").tag(0)
                    Text("Upcoming").tag(1)
                    Text("Previous").tag(2)
                }
                .pickerStyle(.segmented)
                .padding()

                ScrollView {
                    LazyVStack(spacing: 12) {
                        switch selectedTab {
                        case 0:
                            appointmentList(todayAppointments, emptyMessage: "No appointments today")
                        case 1:
                            appointmentList(upcomingAppointments, emptyMessage: "No upcoming appointments")
                        default:
                            appointmentList(previousAppointments, emptyMessage: "No previous appointments")
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .background(Color(.systemGray6))
            .navigationTitle("My Appointments")
        }
    }

    @ViewBuilder
    func appointmentList(_ list: [Appointment], emptyMessage: String) -> some View {
        if list.isEmpty {
            VStack(spacing: 12) {
                Image(systemName: "calendar.badge.exclamationmark")
                    .font(.system(size: 50))
                    .foregroundColor(.gray.opacity(0.4))
                Text(emptyMessage)
                    .foregroundColor(.cfTextSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        } else {
            ForEach(list) { appointment in
                NavigationLink(destination: destinationView(for: appointment)) {
                    AppointmentCard(appointment: appointment)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
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
