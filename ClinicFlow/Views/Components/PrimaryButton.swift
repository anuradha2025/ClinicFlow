//
//  PrimaryButton.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isFullWidth: Bool = true

    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: isFullWidth ? .infinity : nil)
                .padding(.vertical, 14)
                .padding(.horizontal, 24)
                .background(Color.cfPrimary)
                .cornerRadius(12)
        }
    }
}
