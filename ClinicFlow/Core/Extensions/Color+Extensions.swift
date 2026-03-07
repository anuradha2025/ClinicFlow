//
//  Color+Extensions.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

// Core/Extensions/Color+Extensions.swift
import SwiftUI

extension Color {
    static let cfPrimary       = Color(hex: "#2563EB")   // Blue
    static let cfPrimaryLight  = Color(hex: "#EFF6FF")
    static let cfSuccess       = Color(hex: "#10B981")   // Green
    static let cfWarning       = Color(hex: "#F59E0B")   // Orange
    static let cfDanger        = Color(hex: "#EF4444")   // Red
    static let cfBackground    = Color(hex: "#F8FAFF")
    static let cfCardBg        = Color.white
    static let cfTextPrimary   = Color(hex: "#1E293B")
    static let cfTextSecondary = Color(hex: "#64748B")

    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r = Double((int >> 16) & 0xFF) / 255
        let g = Double((int >> 8)  & 0xFF) / 255
        let b = Double(int         & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
}
