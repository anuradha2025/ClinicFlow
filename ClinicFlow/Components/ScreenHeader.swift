//
//  ScreenHeader.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI


// MARK: - Screen Header

struct ScreenHeader: View {
    var title:    String
    var onBack:   (() -> Void)? = nil
    var showBell: Bool = true

    // Notification sheet state — hoisted here so any screen can trigger it
    @State private var showNotifications = false

    var body: some View {
        HStack(spacing: 0) {

            // Leading — back button or spacer
            if let back = onBack {
                Button(action: back) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.cfTextPrimary)
                        .frame(width: 44, height: 44)
                        .background(Color.cfBg)
                        .clipShape(Circle())
                }
                .accessibilityLabel("Back")
            } else {
                Spacer().frame(width: 44)
            }

            Spacer()

            Text(title)
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.cfTextPrimary)

            Spacer()

            // Trailing — bell or spacer
            if showBell {
                Button { showNotifications = true } label: {
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.cfTextPrimary)
                        // Unread badge
                        Circle()
                            .fill(Color.cfDanger)
                            .frame(width: 9, height: 9)
                            .offset(x: 3, y: -2)
                    }
                }
                .frame(width: 44, height: 44)
                .accessibilityLabel("Notifications")
                .sheet(isPresented: $showNotifications) {
                    NotificationsView(isPresented: $showNotifications)
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                }
            } else {
                Spacer().frame(width: 44)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        // Extend the card background behind the status bar automatically
        .background(
            Color.cfCard
                .ignoresSafeArea(edges: .top)
                .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 3)
        )
    }
}

