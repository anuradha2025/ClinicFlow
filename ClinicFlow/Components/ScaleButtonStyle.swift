//
//  ScaleButtonStyle.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

// MARK: - Scale Press Button Style
struct ScaleButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .opacity(isEnabled ? 1.0 : 0.5)
            .animation(.easeInOut(duration: 0.12), value: configuration.isPressed)
    }
}


