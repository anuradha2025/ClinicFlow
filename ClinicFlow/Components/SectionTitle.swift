//
//  SectionTitle.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI



// MARK: - Section Title
struct SectionLabel: View {
    let text: String
    var icon: String? = nil

    var body: some View {
        HStack(spacing: 6) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundColor(.cfBlue)
            }
            Text(text)
                .font(.system(size: 15, weight: .bold))
                .foregroundColor(.cfTextPrimary)
        }
    }
}

