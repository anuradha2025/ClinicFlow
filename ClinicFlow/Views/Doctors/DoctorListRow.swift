//
//  DoctorListRow.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct DoctorListRow: View {
    let doctor: Doctor
    let onFavorite: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            DoctorAvatarView(imageName: doctor.imageName, size: 56)
            VStack(alignment: .leading, spacing: 4) {
                Text(doctor.name).font(.subheadline.bold())
                Text(doctor.specialty).font(.caption).foregroundColor(.cfTextSecondary)
                StarRatingView(rating: doctor.rating)
                Text("Rs. \(Int(doctor.chargeAmount))").font(.caption).foregroundColor(.cfPrimary)
            }
            Spacer()
            Button(action: onFavorite) {
                Image(systemName: doctor.isFavorite ? "heart.fill" : "heart")
                    .foregroundColor(doctor.isFavorite ? .cfDanger : .gray)
                    .frame(width: 44, height: 44)
            }
            .accessibilityLabel(doctor.isFavorite ? "Remove from favourites" : "Add to favourites")
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
    }
}
