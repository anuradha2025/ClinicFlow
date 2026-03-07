//
//  UpcomingAppointmentCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct UpcomingAppointmentCard: View {
    let appointment: Appointment

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                DoctorAvatarView(imageName: appointment.doctor.imageName, size: 44)
                VStack(alignment: .leading, spacing: 2) {
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
                Text(appointment.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.cfTextSecondary)
            }
        }
        .padding()
        .frame(width: 280)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
