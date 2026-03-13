//
//  ProfileView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-12.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var showNotifications = false

    private var unreadCount: Int {
        SampleNotifications.all.filter { !$0.isRead }.count
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.cfBg.ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack {
                        Text("My Profile")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.cfTextPrimary)
                        Spacer()
                        NotificationBellButton(unreadCount: unreadCount) {
                            showNotifications = true
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)

                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 20) {

                            // Profile Header
                            VStack(spacing: 12) {
                                ZStack {
                                    Circle()
                                        .fill(Color.cfBlue.opacity(0.12))
                                        .frame(width: 100, height: 100)
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 44))
                                        .foregroundColor(.cfBlue)
                                }
                                Text("Sarah Johnson")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.cfTextPrimary)
                                Text("sarah.johnson@email.com")
                                    .font(.system(size: 14))
                                    .foregroundColor(.cfTextSecondary)

                                TagPill(text: "Premium Member", color: .cfBlue, filled: true)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 24)
                            .background(Color.cfCard)
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 3)

                            // Profile Options
                            CFCard {
                                VStack(spacing: 0) {
                                    ProfileRow(icon: "person.fill",
                                               color: .cfBlue,
                                               title: "Personal Information")
                                    CFDivider().padding(.leading, 52)

                                    ProfileRow(icon: "bell.fill",
                                               color: .cfWarning,
                                               title: "Notifications")
                                    CFDivider().padding(.leading, 52)

                                    ProfileRow(icon: "lock.fill",
                                               color: .cfSuccess,
                                               title: "Privacy & Security")
                                    CFDivider().padding(.leading, 52)

                                    ProfileRow(icon: "creditcard.fill",
                                               color: .cfPurple,
                                               title: "Payment Methods")
                                    CFDivider().padding(.leading, 52)

                                    ProfileRow(icon: "questionmark.circle.fill",
                                               color: .cfBlue,
                                               title: "Help & Support")
                                }
                            }

                            // Sign Out
                            Button {
                                // sign out action
                            } label: {
                                HStack(spacing: 10) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .font(.system(size: 15, weight: .semibold))
                                    Text("Sign Out")
                                        .font(.system(size: 15, weight: .semibold))
                                }
                                .foregroundColor(.cfDanger)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 15)
                                .background(Color.cfDanger.opacity(0.10))
                                .cornerRadius(16)
                            }

                            Spacer().frame(height: 20)
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                    }
                }
            }
        }
        .sheet(isPresented: $showNotifications) {
            NotificationsView(isPresented: $showNotifications)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

// MARK: - Profile Row
struct ProfileRow: View {
    let icon:  String
    let color: Color
    let title: String

    var body: some View {
        Button { } label: {
            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(color.opacity(0.12))
                        .frame(width: 36, height: 36)
                    Image(systemName: icon)
                        .font(.system(size: 14))
                        .foregroundColor(color)
                }
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.cfTextPrimary)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.cfTextTertiary)
            }
            .padding(.vertical, 12)
        }
    }
}
