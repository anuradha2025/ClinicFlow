//
//  SpecialtyFilterBar.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct SpecialtyFilterBar: View {
    let specialties: [String]
    @Binding var selected: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(specialties, id: \.self) { specialty in
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            selected = specialty
                        }
                    } label: {
                        Text(specialty)
                            .font(.subheadline)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(selected == specialty ? Color.cfBlue : Color.white)
                            .foregroundColor(selected == specialty ? .white : .cfTextSecondary)
                            .cornerRadius(20)
                            .shadow(color: selected == specialty ? Color.cfBlue.opacity(0.28) : .clear,
                                    radius: 5, x: 0, y: 2)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .accessibilityAddTraits(selected == specialty ? .isSelected : [])
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}
