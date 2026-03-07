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
                    Text(specialty)
                        .font(.subheadline)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selected == specialty ? Color.cfPrimary : Color.white)
                        .foregroundColor(selected == specialty ? .white : .cfTextSecondary)
                        .cornerRadius(20)
                        .onTapGesture { selected = specialty }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
        }
    }
}
