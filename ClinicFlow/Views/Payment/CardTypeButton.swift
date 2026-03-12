//
//  CardTypeButton.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//
import SwiftUI
// MARK: - Card Type Tab
struct CardTypeTab: View {
    let name:       String
    let icon:       String
    let isSelected: Bool
    let onTap:      () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 8) {
                Image(systemName: icon).font(.system(size: 16, weight: .medium))
                Text(name).font(.system(size: 13, weight: .semibold))
            }
            .foregroundColor(isSelected ? .white : .cfTextSecondary)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(isSelected ? Color.cfBlue : Color.cfBg)
            .cornerRadius(12)
        }
    }
}
