//
//  TagPill.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI



// MARK: - Tag Pill
struct TagPill: View {
    let text:  String
    let color: Color
    var filled: Bool = false

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(filled ? .white : color)
            .padding(.horizontal, 9)
            .padding(.vertical, 4)
            .background(filled ? color : color.opacity(0.13))
            .cornerRadius(7)
    }
}

