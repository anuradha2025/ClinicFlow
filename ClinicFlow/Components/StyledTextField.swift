//
//  StyledTextField.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI


// MARK: - Styled Text Field
struct CFTextField: View {
    let label:       String
    let placeholder: String
    let icon:        String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.cfTextSecondary)
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.system(size: 14))
                    .foregroundColor(.cfBlue)
                    .frame(width: 18)
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .font(.system(size: 14))
                } else {
                    TextField(placeholder, text: $text)
                        .keyboardType(keyboard)
                        .font(.system(size: 14))
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 13)
            .background(Color.cfBg)
            .cornerRadius(13)
        }
    }
}


