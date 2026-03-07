//
//  TimeSlotPickerView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct TimeSlotPickerView: View {
    let slots: [TimeSlot]
    @Binding var selected: String?

    var body: some View {
        HStack(spacing: 12) {
            ForEach(slots) { slot in
                VStack(spacing: 4) {
                    Text(slot.time)
                        .font(.subheadline.bold())
                    Text("\(slot.availableCount)")
                        .font(.caption)
                        .foregroundColor(.cfTextSecondary)
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 16)
                .background(selected == slot.time ? Color.cfPrimary : Color.white)
                .foregroundColor(selected == slot.time ? .white : .cfTextPrimary)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(selected == slot.time ? Color.cfPrimary : Color.gray.opacity(0.2), lineWidth: 1)
                )
                .onTapGesture { selected = slot.time }
            }
        }
        .padding(.horizontal)
    }
}
