//
//   NotificationsView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

// MARK: - Notification Model
struct CFNotification: Identifiable {
    let id         = UUID()
    let title:      String
    let message:    String
    let time:       String
    let icon:       String
    let iconColor:  Color
    let type:       NotifType
    var isRead:     Bool

    enum NotifType {
        case booking, reminder, result, promo, system
    }
}

// MARK: - Sample Data
let sampleNotifications: [CFNotification] = [
    CFNotification(
        title: "Booking Confirmed",
        message: "Your Fasting Blood Sugar Test is booked for Wednesday, 12 March 2026 at 08:00 AM.",
        time: "Just now",
        icon: "calendar.badge.checkmark",
        iconColor: .cfSuccess,
        type: .booking,
        isRead: false
    ),
    CFNotification(
        title: "Test Reminder",
        message: "Reminder: Your Fasting Blood Sugar Test is tomorrow. Remember to fast for 8-12 hours.",
        time: "2 hours ago",
        icon: "bell.badge.fill",
        iconColor: .cfWarning,
        type: .reminder,
        isRead: false
    ),
    CFNotification(
        title: "Results Ready",
        message: "Your Full Blood Count (CBC) results are now available. Tap to view your report.",
        time: "Yesterday",
        icon: "doc.text.fill",
        iconColor: .cfBlue,
        type: .result,
        isRead: false
    ),
    CFNotification(
        title: "Special Offer",
        message: "Get 20% off on Lipid Profile and Thyroid Function Tests this week only. Book now!",
        time: "2 days ago",
        icon: "tag.fill",
        iconColor: .cfPurple,
        type: .promo,
        isRead: true
    ),
    CFNotification(
        title: "Payment Successful",
        message: "Payment of Rs. 2,500 for Fasting Blood Sugar Test received successfully.",
        time: "3 days ago",
        icon: "checkmark.seal.fill",
        iconColor: .cfSuccess,
        type: .system,
        isRead: true
    ),
    CFNotification(
        title: "Test Reminder",
        message: "Your Lipid Profile test is on Friday. Avoid fatty foods and alcohol the day before.",
        time: "4 days ago",
        icon: "bell.badge.fill",
        iconColor: .cfWarning,
        type: .reminder,
        isRead: true
    ),
    CFNotification(
        title: "Results Ready",
        message: "Your Thyroid Function Test (TSH, T3, T4) results are available. Download your report.",
        time: "1 week ago",
        icon: "doc.text.fill",
        iconColor: .cfBlue,
        type: .result,
        isRead: true
    ),
   
        CFNotification(
            title: "Urine Test Reminder",
            message: "Reminder: Collect your first morning urine sample tomorrow for your UFR test at 09:00 AM.",
            time: "1 hour ago",
            icon: "bell.badge.fill",
            iconColor: .cfWarning,
            type: .reminder,
            isRead: false
        ),
        CFNotification(
            title: "Results Ready",
            message: "Your Urine Full Report (UFR) results are now available. Tap to view your report.",
            time: "3 hours ago",
            icon: "doc.text.fill",
            iconColor: .cfBlue,
            type: .result,
            isRead: false
        ),
        CFNotification(
            title: "Urine Culture Results",
            message: "Your Urine Culture & Sensitivity results are ready. Please consult your doctor for antibiotic prescription.",
            time: "Yesterday",
            icon: "doc.text.fill",
            iconColor: .cfBlue,
            type: .result,
            isRead: false
        ),
       
        CFNotification(
            title: "Special Offer",
            message: "Get 20% off on all Urology tests including UFR, Urine Culture and Microalbumin this week!",
            time: "2 days ago",
            icon: "tag.fill",
            iconColor: .cfPurple,
            type: .promo,
            isRead: true
        ),
        CFNotification(
            title: "Payment Successful",
            message: "Payment of Rs. 800 for Urine Full Report (UFR) has been received successfully.",
            time: "3 days ago",
            icon: "checkmark.seal.fill",
            iconColor: .cfSuccess,
            type: .system,
            isRead: true
        ),
        CFNotification(
            title: "Urine Protein Results",
            message: "Your Urine Protein Test results are available. Download your report from My Reports.",
            time: "4 days ago",
            icon: "doc.text.fill",
            iconColor: .cfBlue,
            type: .result,
            isRead: true
        ),
    CFNotification(
            title: "ESR Results Ready",
            message: "Your Erythrocyte Sedimentation Rate (ESR) test results are now available. Tap to view your report.",
            time: "5 hours ago",
            icon: "doc.text.fill",
            iconColor: .cfBlue,
            type: .result,
            isRead: false
        ),
       
    ]


// MARK: - Notifications View
struct NotificationsView: View {
    @Binding var isPresented: Bool
    @State private var notifications  = sampleNotifications
    @State private var selectedFilter = NotifFilter.all

    enum NotifFilter: String, CaseIterable {
        case all     = "All"
        case unread  = "Unread"
        case booking = "Bookings"
        case results = "Results"
    }

    var filtered: [CFNotification] {
        switch selectedFilter {
        case .all:     return notifications
        case .unread:  return notifications.filter { !$0.isRead }
        case .booking: return notifications.filter { $0.type == .booking || $0.type == .reminder }
        case .results: return notifications.filter { $0.type == .result }
        }
    }

    var unreadCount: Int { notifications.filter { !$0.isRead }.count }

    var body: some View {
        ZStack(alignment: .top) {
            Color.cfBg.ignoresSafeArea()

            VStack(spacing: 0) {

                // Header — presented as a sheet, so no status bar to account for
                HStack {
                    Button { isPresented = false } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.cfTextPrimary)
                            .frame(width: 44, height: 44)
                            .background(Color.cfBg)
                            .clipShape(Circle())
                    }
                    .accessibilityLabel("Close")

                    Spacer()

                    VStack(spacing: 2) {
                        Text("Notifications")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.cfTextPrimary)
                        if unreadCount > 0 {
                            Text("\(unreadCount) unread")
                                .font(.system(size: 11))
                                .foregroundColor(.cfBlue)
                        }
                    }

                    Spacer()

                    Button {
                        withAnimation {
                            for i in notifications.indices { notifications[i].isRead = true }
                        }
                    } label: {
                        Text("All Read")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(unreadCount > 0 ? .cfBlue : .cfTextTertiary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.cfBlueLight)
                            .cornerRadius(8)
                    }
                    .disabled(unreadCount == 0)
                    .accessibilityLabel("Mark all as read")
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 14)
                .background(
                    Color.cfCard
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 3)
                        .ignoresSafeArea(edges: .top)
                )

                // Filter chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(NotifFilter.allCases, id: \.self) { filter in
                            NotifFilterChip(
                                label: filter.rawValue,
                                count: countFor(filter),
                                isSelected: selectedFilter == filter
                            ) {
                                withAnimation(.easeInOut(duration: 0.2)) { selectedFilter = filter }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .background(Color.cfCard)

                // List
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 10) {
                        if filtered.isEmpty {
                            VStack(spacing: 14) {
                                Image(systemName: "bell.slash.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(.cfTextTertiary)
                                Text("No notifications here")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.cfTextSecondary)
                                Text("You are all caught up!")
                                    .font(.system(size: 13))
                                    .foregroundColor(.cfTextTertiary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 60)
                        } else {
                            ForEach(filtered) { notif in
                                NotificationCard(notification: notif) {
                                    markRead(notif)
                                } onDelete: {
                                    delete(notif)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 14)
                    .padding(.bottom, 30)
                }
            }
        }
        .navigationBarHidden(true)
    }

    private func countFor(_ filter: NotifFilter) -> Int {
        switch filter {
        case .all:     return notifications.count
        case .unread:  return notifications.filter { !$0.isRead }.count
        case .booking: return notifications.filter { $0.type == .booking || $0.type == .reminder }.count
        case .results: return notifications.filter { $0.type == .result }.count
        }
    }

    private func markRead(_ notif: CFNotification) {
        if let i = notifications.firstIndex(where: { $0.id == notif.id }) {
            withAnimation { notifications[i].isRead = true }
        }
    }

    private func delete(_ notif: CFNotification) {
        withAnimation(.easeInOut) {
            notifications.removeAll { $0.id == notif.id }
        }
    }
}

// MARK: - Notification Card
struct NotificationCard: View {
    let notification: CFNotification
    let onTap:        () -> Void
    let onDelete:     () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(alignment: .top, spacing: 14) {

                // Icon
                ZStack {
                    Circle()
                        .fill(notification.iconColor.opacity(0.13))
                        .frame(width: 50, height: 50)
                    Image(systemName: notification.icon)
                        .font(.system(size: 20))
                        .foregroundColor(notification.iconColor)
                }

                // Text
                VStack(alignment: .leading, spacing: 5) {
                    HStack(alignment: .top) {
                        Text(notification.title)
                            .font(.system(size: 14, weight: notification.isRead ? .medium : .bold))
                            .foregroundColor(.cfTextPrimary)
                        Spacer()
                        Text(notification.time)
                            .font(.system(size: 11))
                            .foregroundColor(.cfTextTertiary)
                            .padding(.top, 1)
                    }
                    Text(notification.message)
                        .font(.system(size: 13))
                        .foregroundColor(notification.isRead ? .cfTextSecondary : .cfTextPrimary)
                        .lineSpacing(3)
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                    
                    // Type badge
                    TypeBadge(type: notification.type)
                        .padding(.top, 2)
                }

                // Unread dot
                if !notification.isRead {
                    Circle()
                        .fill(Color.cfBlue)
                        .frame(width: 9, height: 9)
                        .padding(.top, 5)
                }
            }
            .padding(14)
            .background(notification.isRead ? Color.cfCard : Color.cfBlue.opacity(0.04))
            .cornerRadius(18)
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(notification.isRead ? Color.clear : Color.cfBlue.opacity(0.15), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(notification.isRead ? 0.04 : 0.07),
                    radius: 8, x: 0, y: 3)
        }
        .buttonStyle(ScaleButtonStyle())
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive, action: onDelete) {
                Label("Delete", systemImage: "trash.fill")
            }
        }
    }
}

// MARK: - Type Badge
struct TypeBadge: View {
    let type: CFNotification.NotifType

    var label: String {
        switch type {
        case .booking:  return "Booking"
        case .reminder: return "Reminder"
        case .result:   return "Result"
        case .promo:    return "Offer"
        case .system:   return "Payment"
        }
    }

    var color: Color {
        switch type {
        case .booking:  return .cfSuccess
        case .reminder: return .cfWarning
        case .result:   return .cfBlue
        case .promo:    return .cfPurple
        case .system:   return .cfSuccess
        }
    }

    var body: some View {
        Text(label)
            .font(.system(size: 10, weight: .semibold))
            .foregroundColor(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color.opacity(0.12))
            .cornerRadius(6)
    }
}

// MARK: - Filter Chip
struct NotifFilterChip: View {
    let label:      String
    let count:      Int
    let isSelected: Bool
    let onTap:      () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 5) {
                Text(label)
                    .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                if count > 0 {
                    Text("\(count)")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(isSelected ? .white : .cfTextTertiary)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(isSelected ? Color.white.opacity(0.25) : Color.cfBg)
                        .cornerRadius(6)
                }
            }
            .foregroundColor(isSelected ? .white : .cfTextSecondary)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? Color.cfBlue : Color.cfBg)
            .cornerRadius(20)
            .shadow(color: isSelected ? Color.cfBlue.opacity(0.28) : .clear, radius: 5, x: 0, y: 2)
        }
    }
}
