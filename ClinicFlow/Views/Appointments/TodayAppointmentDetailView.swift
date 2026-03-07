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
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.cfSuccess)
                        Text("Checked In Successfully")
                            .fontWeight(.semibold)
                            .foregroundColor(.cfSuccess)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(Color.cfSuccess.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }

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
                VStack(alignment: .leading, spacing: 12) {
                    Text("Queue Status")
                        .font(.headline)
                        .padding(.horizontal)

                    VStack(spacing: 0) {
                        HStack {
                            Text("Appointment Number")
                                .font(.caption)
                                .foregroundColor(.cfTextSecondary)
                            Spacer()
                            Text("Status")
                                .font(.caption)
                                .foregroundColor(.cfTextSecondary)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 8)

                        ForEach(appointment.queueEntries) { entry in
                            HStack {
                                Text("\(entry.id)")
                                    .font(.subheadline.bold())
                                    .frame(width: 30)
                                Text(entry.time)
                                    .font(.caption)
                                    .foregroundColor(.cfTextSecondary)
                                Spacer()
                                QueueStatusPill(status: entry.status)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)

                            if entry.id != appointment.queueEntries.last?.id {
                                Divider().padding(.horizontal)
                            }
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 8)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color(.systemGray6))
        .navigationTitle("Appointment Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
