//
//  TimeSlotButton.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI
// MARK: - Time Slot Button
struct TimeSlotButton: View {
    let time:       String
    let isSelected: Bool
    let onTap:      () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(time)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(isSelected ? .white : .cfBlue)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(isSelected ? Color.cfBlue : Color.cfBlueLight)
                .cornerRadius(10)
                .shadow(color: isSelected ? Color.cfBlue.opacity(0.30) : .clear,
                        radius: 5, x: 0, y: 3)
        }
    }
}
