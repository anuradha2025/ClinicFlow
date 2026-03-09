//
//  AppointmentComponents.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-09.
//

import SwiftUI

// MARK: - Apple-style Tab Pill
struct AppointmentTabPill: View {
    let title: String
    let count: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Text(title)
                    .font(.subheadline.bold())
                    .foregroundColor(isSelected ? .cfTextPrimary : .cfTextSecondary)

                Text("\(count)")
                    .font(.caption2.bold())
                    .foregroundColor(isSelected ? .white : .cfTextSecondary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(isSelected ? Color.cfPrimary : Color(.systemGray3))
                    .cornerRadius(8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(isSelected ? Color.white : Color.clear)
            .cornerRadius(11)
            .shadow(color: isSelected ? .black.opacity(0.08) : .clear,
                    radius: 4, x: 0, y: 1)
        }
        .animation(.easeInOut(duration: 0.2), value: isSelected)
    }
}

// MARK: - Improved Appointment Card
struct ImprovedAppointmentCard: View {
    let appointment: Appointment
    @State private var isCheckedIn = false

    var isToday: Bool {
        Calendar.current.isDateInToday(appointment.date)
    }

    var detailDestination: some View {
        Group {
            if Calendar.current.isDateInToday(appointment.date) {
                TodayAppointmentDetailView(appointment: appointment)
            } else if appointment.status == .upcoming {
                UpcomingAppointmentDetailView(appointment: appointment)
            } else {
                PreviousAppointmentDetailView(appointment: appointment)
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Doctor Row
            HStack(spacing: 12) {
                DoctorAvatarView(imageName: appointment.doctor.imageName, size: 52)

                VStack(alignment: .leading, spacing: 3) {
                    Text(appointment.doctor.name)
                        .font(.subheadline.bold())
                        .foregroundColor(.cfTextPrimary)
                    Text(appointment.doctor.specialty)
                        .font(.caption)
                        .foregroundColor(.cfTextSecondary)
                }

                Spacer()

                // Today badge only for today's upcoming
                if isToday && appointment.status == .upcoming {
                    Text("Today")
                        .font(.caption.bold())
                        .foregroundColor(.cfPrimary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.cfPrimaryLight)
                        .cornerRadius(8)
                } else if appointment.status != .upcoming {
                    StatusBadge(status: appointment.status)
                }
            }

            Divider()

            // Date & Time Row
            HStack(spacing: 16) {
                HStack(spacing: 5) {
                    Image(systemName: "clock")
                        .foregroundColor(.cfPrimary)
                        .font(.caption)
                    Text(appointment.time)
                        .font(.caption.bold())
                        .foregroundColor(.cfTextPrimary)
                }
                HStack(spacing: 5) {
                    Image(systemName: "calendar")
                        .foregroundColor(.cfPrimary)
                        .font(.caption)
                    Text(appointment.date.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption.bold())
                        .foregroundColor(.cfTextPrimary)
                }
                Spacer()
            }

            // Action Buttons
            if appointment.status == .upcoming {
                if isToday {
                    HStack(spacing: 10) {
                        // Details → navigates
                        NavigationLink(destination: detailDestination) {
                            Label("Details", systemImage: "doc.text")
                                .font(.subheadline.bold())
                                .foregroundColor(.cfPrimary)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 9)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.cfPrimary, lineWidth: 1.5))
                        }
                        .buttonStyle(PlainButtonStyle())

                        // Check In → stays on screen
                        Button {
                            withAnimation(.spring()) {
                                isCheckedIn.toggle()
                            }
                        } label: {
                            Label(
                                isCheckedIn ? "Checked In" : "Check In",
                                systemImage: isCheckedIn ? "checkmark.seal.fill" : "checkmark.circle"
                            )
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .background(isCheckedIn ? Color.cfSuccess : Color.cfPrimary)
                            .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                } else {
                    // Future appointments — Details only
                    NavigationLink(destination: detailDestination) {
                        Label("Details", systemImage: "doc.text")
                            .font(.subheadline.bold())
                            .foregroundColor(.cfPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 9)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.cfPrimary, lineWidth: 1.5))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            } else {
                // Previous appointments — View Details only
                NavigationLink(destination: detailDestination) {
                    Label("View Details", systemImage: "doc.text")
                        .font(.subheadline.bold())
                        .foregroundColor(.cfTextSecondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 9)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray3), lineWidth: 1.5))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(14)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 10, x: 0, y: 3)
    }
}
