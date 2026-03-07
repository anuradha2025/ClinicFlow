//
//  AppointmentDoctorCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct AppointmentDoctorCard: View {
    let appointment: Appointment

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                DoctorAvatarView(imageName: appointment.doctor.imageName, size: 56)
                VStack(alignment: .leading, spacing: 4) {
                    Text(appointment.doctor.name)
                        .font(.headline)
                    Text(appointment.doctor.specialty)
                        .font(.subheadline)
                        .foregroundColor(.cfTextSecondary)
                    StatusBadge(status: appointment.status)
                }
                Spacer()
            }

            Divider()

            HStack(spacing: 20) {
                Label(appointment.time, systemImage: "clock")
                    .font(.subheadline)
                    .foregroundColor(.cfTextSecondary)
                Label("\(appointment.date.formatted(date: .abbreviated, time: .omitted))",
                      systemImage: "calendar")
                    .font(.subheadline)
                    .foregroundColor(.cfTextSecondary)
                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 8)
    }
}
