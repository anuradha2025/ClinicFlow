//
//  AppointmentCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct AppointmentCard: View {
    let appointment: Appointment

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                DoctorAvatarView(imageName: appointment.doctor.imageName, size: 52)

                VStack(alignment: .leading, spacing: 4) {
                    Text(appointment.doctor.name)
                        .font(.subheadline.bold())
                        .foregroundColor(.cfTextPrimary)
                    Text(appointment.doctor.specialty)
                        .font(.caption)
                        .foregroundColor(.cfTextSecondary)
                }

                Spacer()

                StatusBadge(status: appointment.status)
            }

            Divider()

            HStack {
                Label(appointment.time, systemImage: "clock")
                    .font(.caption)
                    .foregroundColor(.cfTextSecondary)
                Spacer()
                Label(appointment.date.formatted(date: .abbreviated, time: .omitted),
                      systemImage: "calendar")
                    .font(.caption)
                    .foregroundColor(.cfTextSecondary)
            }

            if appointment.status == .upcoming {
                HStack(spacing: 10) {
                    Button("Details") {}
                        .font(.subheadline.bold())
                        .foregroundColor(.cfPrimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.cfPrimary, lineWidth: 1))

                    Button("Check In") {}
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(Color.cfPrimary)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
