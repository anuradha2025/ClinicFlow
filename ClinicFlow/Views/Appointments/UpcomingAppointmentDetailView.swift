//
//  UpcomingAppointmentDetailView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct UpcomingAppointmentDetailView: View {
    let appointment: Appointment

    var isToday: Bool {
        Calendar.current.isDateInToday(appointment.date)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                AppointmentDoctorCard(appointment: appointment)
                    .padding(.horizontal)

                // Reschedule Notice — only for today's appointments
                if isToday {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.cfWarning)
                            Text("Reschedule Notice")
                                .font(.subheadline.bold())
                        }
                        Text("Unfortunately, Dr. \(appointment.doctor.name.components(separatedBy: " ").last ?? "") has requested to reschedule your appointment by 30 mins. Would you like to re-schedule? No extra charge will be applied.")
                            .font(.caption)
                            .foregroundColor(.cfTextSecondary)

                        HStack(spacing: 10) {
                            NavigationLink(destination: BookAppointmentView(doctor: appointment.doctor)) {
                                Text("Re-Schedule")
                                    .font(.subheadline.bold())
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(Color.cfPrimary)
                                    .cornerRadius(10)
                            }
                            Button("No Schedule") {}
                                .font(.subheadline.bold())
                                .foregroundColor(.cfDanger)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.cfDanger, lineWidth: 1))
                        }
                    }
                    .padding()
                    .background(Color.cfWarning.opacity(0.08))
                    .cornerRadius(16)
                    .padding(.horizontal)
                }

                // Queue Stats
                HStack(spacing: 0) {
                    QueueStatItem(value: "\(appointment.queueNumber)",
                                  label: "Your Queue\nNumber",
                                  color: .cfPrimary)
                    Divider().frame(height: 50)
                    QueueStatItem(value: "\(appointment.estimatedWaitNumber)",
                                  label: "Estimated\nWaiting No.",
                                  color: .cfWarning)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8)
                .padding(.horizontal)

                // Queue Status List
                if !appointment.queueEntries.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Queue Status")
                            .font(.headline)
                            .padding(.horizontal)

                        VStack(spacing: 0) {
                            // Header Row
                            HStack {
                                Text("Appointment Number")
                                    .font(.caption)
                                    .foregroundColor(.cfTextSecondary)
                                Spacer()
                                Text("Status")
                                    .font(.caption)
                                    .foregroundColor(.cfTextSecondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.cfBg)

                            // Queue Entries
                            ForEach(appointment.queueEntries) { entry in
                                HStack {
                                    Text("\(entry.id)")
                                        .font(.subheadline.bold())
                                        .foregroundColor(.cfTextPrimary)
                                        .frame(width: 24, alignment: .leading)
                                    Text(entry.time)
                                        .font(.subheadline)
                                        .foregroundColor(.cfTextSecondary)
                                        .padding(.leading, 8)
                                    Spacer()
                                    if isToday || (entry.status != .finished && entry.status != .checkedIn) {
                                        QueueStatusPill(status: entry.status)
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)

                                if entry.id != appointment.queueEntries.last?.id {
                                    Divider()
                                        .padding(.horizontal, 16)
                                }
                            }
                        }
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 8)
                        .padding(.horizontal)
                    }
                }

                // Action Buttons
                VStack(spacing: 10) {
                    NavigationLink(destination: BookAppointmentView(doctor: appointment.doctor)) {
                        Text("Reschedule Appointment")
                            .fontWeight(.semibold)
                            .foregroundColor(.cfPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.cfPrimary, lineWidth: 1))
                    }

                    Button {} label: {
                        Text("Cancel Appointment")
                            .fontWeight(.semibold)
                            .foregroundColor(.cfDanger)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .overlay(RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.cfDanger, lineWidth: 1))
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.cfBg)
        .navigationTitle("Appointment Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
