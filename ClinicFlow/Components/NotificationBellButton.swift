//
//  NotificationBellButton.swift
//  ClinicFlow
//
//  Created by GitHub Copilot on 2026-03-13.
//

import SwiftUI

struct NotificationBellButton: View {
    let unreadCount: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "bell")
                    .font(.title3)
                    .foregroundColor(.cfTextPrimary)
                    .padding(10)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.06), radius: 6)

                if unreadCount > 0 {
                    ZStack {
                        Circle()
                            .fill(Color.cfDanger)
                            .frame(width: 18, height: 18)
                        Text("\(unreadCount)")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundColor(.white)
                    }
                    .offset(x: 2, y: -2)
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel(unreadCount > 0 ? "Notifications, \(unreadCount) unread" : "Notifications")
    }
}
