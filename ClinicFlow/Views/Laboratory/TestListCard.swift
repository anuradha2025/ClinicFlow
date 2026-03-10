//
//  TestListCard.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

struct TestListCard: View {
    let test:  LabTest
    let onTap: () -> Void

    // Map category → colour
    var categoryColor: Color {
        switch test.category {
        case "Diabetes":       return .cfBlue
        case "Haematology":    return .cfDanger
        case "Cardiology":     return Color(red: 0.95, green: 0.35, blue: 0.35)
        case "Endocrinology":  return .cfPurple
        case "Gastroenterology": return .cfWarning
        default:               return .cfBlue
        }
    }
    
    

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 14) {

                // Icon box
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(categoryColor.opacity(0.12))
                        .frame(width: 64, height: 64)
                    Image(systemName: test.iconName)
                        .font(.system(size: 26, weight: .medium))
                        .foregroundColor(categoryColor)
                }

                // Text
                VStack(alignment: .leading, spacing: 6) {
                    Text(test.name)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.cfTextPrimary)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)

                    HStack(spacing: 6) {
                        TagPill(text: test.category, color: categoryColor)
                        TagPill(text: test.duration, color: .cfSuccess)
                    }

                    Text("Rs. \(test.price)/=")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(categoryColor)
                }

                Spacer()

                // Chevron
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.cfTextTertiary)
            }
            .padding(14)
            .background(Color.cfCard)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.055), radius: 8, x: 0, y: 3)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
