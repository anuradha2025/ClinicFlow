//
//  PrimaryButton.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//


import SwiftUI
// MARK: - Primary Button
struct PrimaryButton: View {
    let title:  String
    var icon:   String? = nil
    var color:  Color   = .cfBlue
    let action: () -> Void

    @Environment(\.isEnabled) private var isEnabled

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon { Image(systemName: icon).font(.system(size: 15, weight: .semibold)) }
                Text(title).font(.system(size: 15, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 15)
            .background(isEnabled ? color : Color.cfTextTertiary)
            .cornerRadius(16)
            .shadow(color: isEnabled ? color.opacity(0.30) : .clear, radius: 8, x: 0, y: 4)
            .contentShape(Rectangle())
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

