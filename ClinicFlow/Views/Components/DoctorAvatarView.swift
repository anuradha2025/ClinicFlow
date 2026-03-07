//
//  DoctorAvatarView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct DoctorAvatarView: View {
    let imageName: String
    let size: CGFloat

    // Generates a color from the doctor's name
    var avatarColor: Color {
        let colors: [Color] = [.cfPrimary, .cfSuccess, .cfWarning, .cfDanger,
                                Color(hex: "#8B5CF6"), Color(hex: "#EC4899")]
        let index = abs(imageName.hashValue) % colors.count
        return colors[index]
    }

    var initials: String {
        let parts = imageName.replacingOccurrences(of: "doctor_", with: "")
                             .split(separator: "_")
        return parts.prefix(2).compactMap { $0.first?.uppercased() }.joined()
    }

    var body: some View {
        // Try to load real image first, fallback to initials
        if let _ = UIImage(named: imageName) {
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
        } else {
            Circle()
                .fill(avatarColor.opacity(0.2))
                .frame(width: size, height: size)
                .overlay(
                    Text(initials)
                        .font(.system(size: size * 0.35, weight: .bold))
                        .foregroundColor(avatarColor)
                )
                .overlay(Circle().stroke(avatarColor.opacity(0.3), lineWidth: 1.5))
        }
    }
}
