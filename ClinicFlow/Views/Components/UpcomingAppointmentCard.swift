//
//  UpcomingAppointmentCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct UpcomingAppointmentCard: View {
    let appointment: Appointment

    var isToday: Bool {
        Calendar.current.isDateInToday(appointment.date)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
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

                // Only show "Today" badge for actual today appointments
                if isToday {
                    Text("Today")
                        .font(.caption.bold())
                        .foregroundColor(.cfPrimary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.cfPrimaryLight)
                        .cornerRadius(8)
                }
            }

            Divider()

            HStack {
                Label(appointment.time, systemImage: "clock")
                    .font(.caption)
                    .foregroundColor(.cfTextSecondary)
                Spacer()
                Text(appointment.date.formatted(date: .long, time: .omitted))
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
