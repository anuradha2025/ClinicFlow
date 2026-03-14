//
//  Color+Extensions.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

// Core/Extensions/Color+Extensions.swift
import SwiftUI

extension Color {
    // Aliases — all views should prefer the semantic values in Colors.swift.
    // These exist to keep older code compiling without changes.
    static let cfPrimary      = Color.cfBlue
    static let cfPrimaryLight = Color.cfBlueLight
    static let cfBackground   = Color.cfBg
    static let cfCardBg       = Color.cfCard

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
