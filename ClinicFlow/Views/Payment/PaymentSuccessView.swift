//
//  PaymentSuccessView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct PaymentSuccessView: View {
    let doctor: Doctor
    let billing: BillingInfo
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss


    var confirmedAppointment: Appointment {
        Appointment(
            id: UUID(),
            doctor: doctor,
            date: Date(),
            time: "12:00 PM",
            status: .upcoming,
            queueNumber: 6,
            estimatedWaitNumber: 65,
            prescription: [],
            labTests: [],
            queueEntries: [
                QueueEntry(id: 1, time: "08:30 AM", status: .finished),
                QueueEntry(id: 2, time: "09:15 AM", status: .checkedIn),
                QueueEntry(id: 3, time: "10:00 AM", status: .ongoing),
                QueueEntry(id: 4, time: "10:45 AM", status: .cancelled),
                QueueEntry(id: 5, time: "11:30 AM", status: .cancelled),
                QueueEntry(id: 6, time: "12:00 PM", status: .you),
            ]
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            Spacer()

            // Success Icon
            ZStack {
                Circle()
                    .fill(Color.cfSuccess.opacity(0.12))
                    .frame(width: 110, height: 110)
                Circle()
                    .fill(Color.cfSuccess)
                    .frame(width: 80, height: 80)
                Image(systemName: "checkmark")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 24)

            Text("Thanks, your booking has\nbeen confirmed.")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .foregroundColor(.cfTextPrimary)
                .padding(.bottom, 10)

            Text("Please check your email for receipt\nand booking details.")
                .font(.subheadline)
                .foregroundColor(.cfTextSecondary)
                .multilineTextAlignment(.center)
                .padding(.bottom, 32)

            // Booking Summary Card
            VStack(spacing: 16) {
                HStack(spacing: 14) {
                    DoctorAvatarView(imageName: doctor.imageName, size: 56)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(doctor.name)
                            .font(.headline)
                            .foregroundColor(.cfTextPrimary)
                        Text(doctor.specialty)
                            .font(.subheadline)
                            .foregroundColor(.cfTextSecondary)
                    }
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.cfSuccess)
                        .font(.title2)
                }

                Divider()

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Date")
                            .font(.caption)
                            .foregroundColor(.cfTextSecondary)
                        Text(Date().formatted(date: .abbreviated, time: .omitted))
                            .font(.subheadline.bold())
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Time")
                            .font(.caption)
                            .foregroundColor(.cfTextSecondary)
                        Text("12:00 PM")
                            .font(.subheadline.bold())
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Amount")
                            .font(.caption)
                            .foregroundColor(.cfTextSecondary)
                        Text("Rs. \(Int(billing.total))")
                            .font(.subheadline.bold())
                            .foregroundColor(.cfPrimary)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.07), radius: 12, x: 0, y: 4)
            .padding(.horizontal, 24)

            Spacer()

            // Appointment Details Button
            NavigationLink(destination: TodayAppointmentDetailView(appointment: confirmedAppointment)) {
                Text("Appointment Details")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.cfPrimary)
                    .cornerRadius(14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 12)

            // Back to Home — switches to Home tab and pops stack
            Button {
                appState.selectedTab = 0
                appState.popToRoot = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    appState.popToRoot = false
                }
            } label: {
                Text("Back to Home")
                    .fontWeight(.medium)
                    .foregroundColor(.cfPrimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
        }
        .background(Color.cfBackground.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}
