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
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.cfSuccess)

            Text("Thanks, your booking has\nbeen confirmed.")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .foregroundColor(.cfTextPrimary)

            Text("Please check your email for receipt\nand booking details.")
                .font(.subheadline)
                .foregroundColor(.cfTextSecondary)
                .multilineTextAlignment(.center)

            // Doctor appointment summary card
            VStack(alignment: .leading, spacing: 8) {
                DoctorAvatarView(imageName: doctor.imageName, size: 48)
                Text(doctor.name).font(.headline)
                Text(doctor.specialty).foregroundColor(.cfTextSecondary).font(.subheadline)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.cfCardBg)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.06), radius: 8)
            .padding(.horizontal)

            Spacer()

            PrimaryButton(title: "See all details") {
                dismiss()
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.cfBackground)
    }
}
