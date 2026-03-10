//
//  TopDoctorCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct TopDoctorCard: View {
    let doctor: Doctor

    var body: some View {
        HStack(spacing: 12) {
            DoctorAvatarView(imageName: doctor.imageName, size: 56)

            VStack(alignment: .leading, spacing: 4) {
                Text(doctor.name)
                    .font(.subheadline.bold())
                    .foregroundColor(.cfTextPrimary)
                Text(doctor.specialty)
                    .font(.caption)
                    .foregroundColor(.cfTextSecondary)
                StarRatingView(rating: doctor.rating)
            }

            Spacer()

            Text("Rs. \(Int(doctor.chargeAmount))")
                .font(.subheadline.bold())
                .foregroundColor(.cfPrimary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
