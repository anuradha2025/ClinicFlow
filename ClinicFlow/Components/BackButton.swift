//
//  BackButton.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

// MARK: - Secondary Button
struct SecondaryButton: View {
    let title:  String
    var icon:   String? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon { Image(systemName: icon).font(.system(size: 14, weight: .medium)) }
                Text(title).font(.system(size: 14, weight: .medium))
            }
            .foregroundColor(.cfBlue)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background(Color.cfBlueLight)
            .cornerRadius(16)
        }
        .buttonStyle(ScaleButtonStyle())
    }
}


