//
//  AppointmentLaboratoryReferralView.swift
//  ClinicFlow
//
//  Created by GitHub Copilot on 2026-03-12.
//

import SwiftUI

struct AppointmentLaboratoryReferralView: View {
    let appointment: Appointment

    @EnvironmentObject var nav: AppNavigation
    @EnvironmentObject var appState: AppState

    private var requiredTests: [LabTest] {
        appointment.labTests.map { $0.asBookableLabTest() }
    }

    private var appointmentDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, d MMM yyyy"
        return formatter.string(from: appointment.date)
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.cfBg.ignoresSafeArea()

            VStack(spacing: 0) {
                ScreenHeader(title: "Laboratory", onBack: { nav.referralAppointment = nil })

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {
                        referralSummaryCard
                        requiredTestsCard
                        preparationCard

                        Spacer().frame(height: 110)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                }
            }

            VStack(spacing: 10) {
                CFDivider()

                PrimaryButton(title: "Open Laboratory", icon: "cross.case.fill") {
                    nav.exitLabFlow()
                    appState.selectedTab = 4
                }

                Text("Select a required test above to continue with booking.")
                    .font(.system(size: 12))
                    .foregroundColor(.cfTextSecondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.cfCard)
        }
    }

    private var referralSummaryCard: some View {
        CFCard {
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 14) {
                    ZStack {
                        Circle()
                            .fill(Color.cfSuccess.opacity(0.14))
                            .frame(width: 56, height: 56)

                        Image(systemName: "cross.case.fill")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.cfSuccess)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Doctor Referral")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.cfSuccess)

                        Text("\(requiredTests.count) test\(requiredTests.count == 1 ? "" : "s") requested by Dr. \(appointment.doctor.name)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.cfTextPrimary)

                        Text("From your appointment on \(appointmentDate)")
                            .font(.system(size: 13))
                            .foregroundColor(.cfTextSecondary)
                    }
                }

                HStack(spacing: 12) {
                    referralInfoChip(icon: "clock.fill", text: "Book a slot")
                    referralInfoChip(icon: "doc.text.fill", text: "Use referral")
                    referralInfoChip(icon: "checkmark.seal.fill", text: "Get reports")
                }
            }
        }
    }

    private var requiredTestsCard: some View {
        CFCard(padding: 0) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    SectionLabel(text: "Required Tests", icon: "list.bullet.clipboard")
                    Spacer()
                    Text("\(requiredTests.count)")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.cfSuccess)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(Color.cfSuccess.opacity(0.12))
                        .clipShape(Capsule())
                }
                .padding(16)

                CFDivider()

                ForEach(Array(requiredTests.enumerated()), id: \.element.id) { index, test in
                    Button {
                        nav.selectedTest = test
                    } label: {
                        HStack(spacing: 14) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.cfBlue.opacity(0.12))
                                    .frame(width: 52, height: 52)

                                Image(systemName: test.iconName)
                                    .font(.system(size: 21, weight: .medium))
                                    .foregroundColor(.cfBlue)
                            }

                            VStack(alignment: .leading, spacing: 6) {
                                Text(test.name)
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.cfTextPrimary)
                                    .multilineTextAlignment(.leading)

                                HStack(spacing: 8) {
                                    TagPill(text: test.category, color: .cfBlue)
                                    TagPill(text: test.duration, color: .cfSuccess)
                                }
                            }

                            Spacer()

                            VStack(alignment: .trailing, spacing: 6) {
                                Text("Rs. \(test.price)/=")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundColor(.cfBlue)

                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(.cfTextTertiary)
                            }
                        }
                        .padding(16)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())

                    if index < requiredTests.count - 1 {
                        CFDivider().padding(.leading, 82)
                    }
                }
            }
        }
    }

    private var preparationCard: some View {
        CFCard {
            VStack(alignment: .leading, spacing: 12) {
                SectionLabel(text: "Before You Visit", icon: "bell.badge.fill")

                referralReminder(text: "Carry the referral from your completed appointment when you arrive.")
                referralReminder(text: "Choose one test to continue. Each selected test opens the full booking and payment flow.")
                referralReminder(text: "If you need a different investigation, use the laboratory tab to browse the full test catalog.")
            }
        }
    }

    private func referralInfoChip(icon: String, text: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 11, weight: .semibold))
            Text(text)
                .font(.system(size: 11, weight: .medium))
        }
        .foregroundColor(.cfTextSecondary)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color.cfBg)
        .clipShape(Capsule())
    }

    private func referralReminder(text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 14))
                .foregroundColor(.cfSuccess)
                .padding(.top, 1)

            Text(text)
                .font(.system(size: 13))
                .foregroundColor(.cfTextSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}