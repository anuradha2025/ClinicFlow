//
//  CardContainer.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI



// MARK: - Card Container
struct CFCard<Content: View>: View {
    var padding: CGFloat = 16
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            content()
        }
        .padding(padding)
        .background(Color.cfCard)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.055), radius: 10, x: 0, y: 4)
    }
}

