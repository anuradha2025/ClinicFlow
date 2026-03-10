//
//  SectionHeader.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct SectionHeader: View {
    let title: String
    let actionTitle: String
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.cfTextPrimary)
            Spacer()
            Button(action: action) {
                Text(actionTitle)
                    .font(.subheadline)
                    .foregroundColor(.cfPrimary)
            }
        }
        .padding(.horizontal)
    }
}
