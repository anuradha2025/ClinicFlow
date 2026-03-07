//
//  StarRatingView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct StarRatingView: View {
    let rating: Double
    let maxRating: Int = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= Int(rating.rounded()) ? "star.fill" : "star")
                    .foregroundColor(.cfWarning)
                    .font(.caption)
            }
            Text(String(format: "%.1f", rating))
                .font(.caption.bold())
                .foregroundColor(.cfTextPrimary)
        }
    }
}
