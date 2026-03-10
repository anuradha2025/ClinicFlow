//
//  TodayAppointmentDetailView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct TodayAppointmentDetailView: View {
    let appointment: Appointment
    @State private var isCheckedIn = false

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                // Doctor Info Card
                AppointmentDoctorCard(appointment: appointment)
                    .padding(.horizontal)

                // Check In Banner
                if !isCheckedIn {
                    Button {
                        isCheckedIn = true
                    } label: {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Check In Now")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.cfSuccess)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)
                } else {
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.cfSuccess)
                        Text("Checked In Successfully")
                            .fontWeight(.semibold)
                            .foregroundColor(.cfSuccess)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.cfSuccess, lineWidth: 1.5)
                    )
                    .shadow(color: Color.cfSuccess.opacity(0.15), radius: 8)
                    .padding(.horizontal)
                }
                
                // Reschedule Notice
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
                        .lineSpacing(3)

                    NavigationLink(destination: BookAppointmentView(doctor: appointment.doctor)) {
                        Text("Re-Schedule")
                            .font(.subheadline.bold())
                            .foregroundColor(.cfPrimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.cfPrimary, lineWidth: 1.5)
                            )
                    }
                }
                .padding()
                .background(Color.cfWarning.opacity(0.08))
                .cornerRadius(16)
                .padding(.horizontal)

                // Queue Stats
                HStack(spacing: 0) {
                    QueueStatItem(
                        value: "\(appointment.queueNumber)",
                        label: "Your Queue\nNumber",
                        color: .cfPrimary
                    )
                    Divider().frame(height: 50)
                    QueueStatItem(
                        value: "\(appointment.estimatedWaitNumber)",
                        label: "Estimated\nWaiting No.",
                        color: .cfWarning
                    )
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
                                    .font(.caption.bold())
                                    .foregroundColor(.cfTextSecondary)
                                Spacer()
                                Text("Status")
                                    .font(.caption.bold())
                                    .foregroundColor(.cfTextSecondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 14)
                            .padding(.bottom, 10)

                            Divider()
                                .padding(.horizontal, 16)

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
                                    QueueStatusPill(status: entry.status)
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
            }
            .padding(.vertical)
        }
        .background(Color(.systemGray6))
        .navigationTitle("Appointment Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
