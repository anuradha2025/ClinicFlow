//
//  LabPaymentSuccessView.swift
//  ClinicFlow
//
//  Extracted from Thulani branch payment success for laboratory flow.
//

import SwiftUI

struct LabPaymentSuccessView: View {
    let test: LabTest
    @EnvironmentObject var nav: AppNavigation
    @EnvironmentObject var appState: AppState

    @State private var checkScale: CGFloat   = 0.4
    @State private var checkOpacity: Double  = 0
    @State private var ringScale: CGFloat    = 0.6
    @State private var contentOffset: CGFloat = 40
    @State private var contentOpacity: Double = 0

    var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "EEEE, d MMMM yyyy"
        return f.string(from: nav.bookedDate)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.cfBg.ignoresSafeArea()

            VStack(spacing: 0) {
                ScreenHeader(title: "Booking Confirmed", showBell: false)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {

                        // Success Animation
                        VStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(Color.cfSuccess.opacity(0.08))
                                    .frame(width: 130, height: 130)
                                    .scaleEffect(ringScale)

                                Circle()
                                    .fill(Color.cfSuccess.opacity(0.15))
                                    .frame(width: 100, height: 100)

                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 62))
                                    .foregroundColor(.cfSuccess)
                                    .scaleEffect(checkScale)
                                    .opacity(checkOpacity)
                            }

                            Text("Booking Confirmed!")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.cfTextPrimary)

                            Text("Your appointment is all set.\nCheck your email for receipt & details.")
                                .font(.system(size: 14))
                                .foregroundColor(.cfTextSecondary)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                        }
                        .padding(.top, 24)
                        .offset(y: contentOffset)
                        .opacity(contentOpacity)

                        // Booking Detail Card
                        CFCard(padding: 0) {
                            VStack(spacing: 0) {
                                HStack {
                                    Text("Appointment Details")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.cfTextPrimary)
                                    Spacer()
                                    TagPill(text: "Confirmed", color: .cfSuccess, filled: true)
                                }
                                .padding(16)

                                CFDivider()

                                BookingRow(icon: test.iconName, color: .cfBlue,
                                           title: test.name, sub: "Rs. \(test.price)/=")
                                CFDivider().padding(.leading, 58)

                                BookingRow(icon: "calendar", color: .cfPurple,
                                           title: formattedDate, sub: "Appointment Date")
                                CFDivider().padding(.leading, 58)

                                BookingRow(icon: "clock.fill", color: .cfWarning,
                                           title: nav.bookedTime, sub: "Appointment Time")
                                CFDivider().padding(.leading, 58)

                                BookingRow(icon: "building.2.fill", color: .cfSuccess,
                                           title: "Main Laboratory", sub: "Location")
                            }
                        }
                        .offset(y: contentOffset)
                        .opacity(contentOpacity)

                        // Reminder Card
                        CFCard {
                            VStack(alignment: .leading, spacing: 12) {
                                SectionLabel(text: "Pre-Test Reminders", icon: "bell.badge.fill")
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(test.beforeTest.prefix(4), id: \.self) { item in
                                        HStack(alignment: .top, spacing: 10) {
                                            Image(systemName: "checkmark.circle.fill")
                                                .font(.system(size: 14))
                                                .foregroundColor(.cfBlue)
                                                .padding(.top, 1)
                                            Text(item)
                                                .font(.system(size: 13))
                                                .foregroundColor(.cfTextSecondary)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                    }
                                }
                            }
                        }
                        .offset(y: contentOffset)
                        .opacity(contentOpacity)

                        Spacer().frame(height: 110)
                    }
                    .padding(.horizontal, 16)
                }
            }

            // Bottom Buttons
            VStack(spacing: 10) {
                CFDivider()
                PrimaryButton(title: "View My Reports", icon: "doc.text.fill") {
                    nav.showReportsTab = true
                    nav.reset()
                    appState.selectedTab = 4
                }
                SecondaryButton(title: "Back to Laboratory", icon: "cross.case.fill") {
                    nav.reset()
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.cfCard)
        }
        .navigationBarHidden(true)
        .onAppear { animate() }
    }

    private func animate() {
        withAnimation(.spring(response: 0.45, dampingFraction: 0.60)) {
            checkScale   = 1.0
            checkOpacity = 1.0
            ringScale    = 1.0
        }
        withAnimation(.easeOut(duration: 0.45).delay(0.15)) {
            contentOffset  = 0
            contentOpacity = 1.0
        }
    }
}
