//
//  HomeView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @EnvironmentObject var appState: AppState
    @State private var showNotifications = false

    var unreadCount: Int {
        SampleNotifications.all.filter { !$0.isRead }.count
    }

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

                        // Bell Button with badge
                        Button {
                            showNotifications = true
                        } label: {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "bell")
                                    .font(.title3)
                                    .foregroundColor(.cfTextPrimary)
                                    .padding(10)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.06), radius: 6)

                                if unreadCount > 0 {
                                    ZStack {
                                        Circle()
                                            .fill(Color.cfDanger)
                                            .frame(width: 18, height: 18)
                                        Text("\(unreadCount)")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    .offset(x: 2, y: -2)
                                }
                            }
                        }
                        .accessibilityLabel(unreadCount > 0 ? "Notifications, \(unreadCount) unread" : "Notifications")
                    }
                    .padding(.horizontal)

                    // Quick Actions
                    QuickActionsRow()
                        .environmentObject(appState)

                    // Upcoming Appointments
                    HStack {
                        Text("Upcoming Appointments")
                            .font(.headline)
                            .foregroundColor(.cfTextPrimary)
                        Spacer()
                        Button {
                            appState.selectedTab = 2
                        } label: {
                            Text("See All")
                                .font(.subheadline)
                                .foregroundColor(.cfPrimary)
                        }
                    }
                    .padding(.horizontal)

                    if vm.upcomingAppointments.isEmpty {
                        Text("No upcoming appointments")
                            .foregroundColor(.cfTextSecondary)
                            .padding(.horizontal)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(vm.upcomingAppointments) { appt in
                                    NavigationLink(destination: appointmentDestination(for: appt)) {
                                        UpcomingAppointmentCard(appointment: appt)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Top Doctors
                    HStack {
                        Text("Top Doctors")
                            .font(.headline)
                            .foregroundColor(.cfTextPrimary)
                        Spacer()
                        Button {
                            appState.selectedTab = 1
                        } label: {
                            Text("See All")
                                .font(.subheadline)
                                .foregroundColor(.cfPrimary)
                        }
                    }
                    .padding(.horizontal)

                    ForEach(vm.topDoctors.prefix(3)) { doctor in
                        NavigationLink(destination: DoctorProfileView(doctor: doctor)) {
                            TopDoctorCard(doctor: doctor)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal)
                    }
                }
                .padding(.top)
                .padding(.bottom, 24)
            }
            .background(Color.cfBackground)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear { vm.loadData() }

        // Notifications Sheet - use Thulani notifications
        .sheet(isPresented: $showNotifications) {
            NotificationsView(isPresented: $showNotifications)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }

    @ViewBuilder
    func appointmentDestination(for appointment: Appointment) -> some View {
        if Calendar.current.isDateInToday(appointment.date) {
            TodayAppointmentDetailView(appointment: appointment)
        } else if appointment.status == .upcoming {
            UpcomingAppointmentDetailView(appointment: appointment)
        } else {
            PreviousAppointmentDetailView(appointment: appointment)
        }
    }
}
