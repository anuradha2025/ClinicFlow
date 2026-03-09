//
//  NotificationsOverlayView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-09.
//

import SwiftUI

struct NotificationsOverlayView: View {
    @Binding var isPresented: Bool
    @State private var notifications = SampleNotifications.all

    var unreadCount: Int {
        notifications.filter { !$0.isRead }.count
    }

    var body: some View {
        VStack(spacing: 0) {

            // Header
            HStack {
                Text("Notifications")
                    .font(.headline)
                Spacer()
                if unreadCount > 0 {
                    Button("Mark all read") {
                        for i in notifications.indices {
                            notifications[i].isRead = true
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.cfPrimary)
                }
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(Color(.systemGray3))
                }
            }
            .padding()

            Divider()

            if notifications.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "bell.slash")
                        .font(.system(size: 44))
                        .foregroundColor(.gray.opacity(0.3))
                    Text("No notifications")
                        .foregroundColor(.cfTextSecondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
            } else {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(notifications.indices, id: \.self) { index in
                            NotificationRow(notification: notifications[index])
                                .onTapGesture {
                                    notifications[index].isRead = true
                                }
                            Divider()
                                .padding(.leading, 70)
                        }
                    }
                }
            }
        }
        .background(Color.white)
        .cornerRadius(20, corners: [.topLeft, .topRight])
    }
}

// MARK: - Notification Row
struct NotificationRow: View {
    let notification: NotificationItem

    var iconColor: Color {
        switch notification.type {
        case .doctorArrived: return .cfSuccess
        case .doctorLate:    return .cfWarning
        case .nextUp:        return .cfPrimary
        case .reminder:      return .cfPrimary
        case .general:       return .cfTextSecondary
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 14) {

            // Icon
            ZStack {
                Circle()
                    .fill(iconColor.opacity(0.12))
                    .frame(width: 44, height: 44)
                Image(systemName: notification.type.icon)
                    .foregroundColor(iconColor)
                    .font(.system(size: 18))
            }

            // Content
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(notification.title)
                        .font(.subheadline.bold())
                        .foregroundColor(.cfTextPrimary)
                    Spacer()
                    Text(notification.time)
                        .font(.caption2)
                        .foregroundColor(.cfTextSecondary)
                }
                Text(notification.message)
                    .font(.caption)
                    .foregroundColor(.cfTextSecondary)
                    .lineSpacing(2)
                    .fixedSize(horizontal: false, vertical: true)
            }

            // Unread dot
            if !notification.isRead {
                Circle()
                    .fill(Color.cfPrimary)
                    .frame(width: 8, height: 8)
                    .padding(.top, 4)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(notification.isRead ? Color.white : Color.cfPrimaryLight.opacity(0.5))
    }
}

// MARK: - Sample Notifications
struct SampleNotifications {
    static let all: [NotificationItem] = [
        NotificationItem(
            type: .nextUp,
            title: "You're Next!",
            message: "You are next in the queue for Dr. Emily Carter. Please be ready at the reception.",
            time: "Just now",
            isRead: false
        ),
        NotificationItem(
            type: .doctorArrived,
            title: "Doctor Has Arrived",
            message: "Dr. Emily Carter has arrived and is ready to see patients. Your appointment is at 12:00 PM.",
            time: "10 min ago",
            isRead: false
        ),
        NotificationItem(
            type: .doctorLate,
            title: "Appointment Delayed",
            message: "Dr. Sarah Mitchell is running 20 minutes late for your 10:30 AM appointment tomorrow. We apologize for the inconvenience.",
            time: "30 min ago",
            isRead: false
        ),
        NotificationItem(
            type: .reminder,
            title: "Appointment Reminder",
            message: "You have an appointment with Dr. Sarah Mitchell tomorrow at 10:30 AM. Don't forget to bring your medical records.",
            time: "1 hr ago",
            isRead: true
        ),
        NotificationItem(
            type: .general,
            title: "Booking Confirmed",
            message: "Your appointment with Dr. Michael Torres on Mar 16 at 2:00 PM has been successfully confirmed.",
            time: "2 hrs ago",
            isRead: true
        ),
        NotificationItem(
            type: .doctorLate,
            title: "Queue Update",
            message: "There are now 3 patients ahead of you in the queue for Dr. Emily Carter. Estimated wait time: 45 minutes.",
            time: "3 hrs ago",
            isRead: true
        ),
        NotificationItem(
            type: .general,
            title: "Lab Results Ready",
            message: "Your lab test results from your appointment with Dr. James Wilson are now available. Check the Reports section.",
            time: "Yesterday",
            isRead: true
        ),
        NotificationItem(
            type: .reminder,
            title: "Take Your Medication",
            message: "Reminder to take your prescribed Paracetamol 500mg. As prescribed by Dr. James Wilson.",
            time: "Yesterday",
            isRead: true
        )
    ]
}
