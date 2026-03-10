//
//  FloatingLabelField.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct FloatingLabelField: View {
    let label: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundColor(.cfTextSecondary)
            Group {
                if isSecure {
                    SecureField(label, text: $text)
                        .textContentType(.oneTimeCode)
                } else {
                    TextField(label, text: $text)
                        .keyboardType(keyboardType)
                }
            }
            .padding(12)
            .background(Color.cfBackground)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        }
    }
}
