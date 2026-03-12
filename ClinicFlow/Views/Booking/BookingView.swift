//
//  BookingView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

struct BookingView: View {
    let test: LabTest
    @EnvironmentObject var nav: AppNavigation

    @State private var selectedDate = Date()
    @State private var selectedSlot = "08:00 AM"

    let slots = ["07:00 AM","08:00 AM","09:00 AM","10:00 AM",
                 "11:00 AM","12:00 PM","02:00 PM","04:00 PM",
                 "06:00 PM","08:00 PM"]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.cfBg.ignoresSafeArea()

            VStack(spacing: 0) {
                ScreenHeader(title: "Book Test", onBack: { nav.showBooking = false })

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {

                        // ── Test Summary Card ─────────────────────────
                        CFCard {
                            HStack(spacing: 14) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(Color.cfBlue.opacity(0.12))
                                        .frame(width: 54, height: 54)
                                    Image(systemName: test.iconName)
                                        .font(.system(size: 22))
                                        .foregroundColor(.cfBlue)
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(test.name)
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.cfTextPrimary)
                                    Text(test.category)
                                        .font(.system(size: 12))
                                        .foregroundColor(.cfTextSecondary)
                                }
                                Spacer()
                                Text("Rs. \(test.price)/=")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.cfBlue)
                            }
                        }

                        // ── Date Picker ───────────────────────────────
                        CFCard {
                            VStack(alignment: .leading, spacing: 10) {
                                SectionLabel(text: "Select Date", icon: "calendar")
                                DatePicker("", selection: $selectedDate,
                                           in: Date()...,
                                           displayedComponents: .date)
                                    .datePickerStyle(.graphical)
                                    .tint(.cfBlue)
                            }
                        }

                        // ── Time Slots ────────────────────────────────
                        CFCard {
                            VStack(alignment: .leading, spacing: 14) {
                                SectionLabel(text: "Select Time Slot", icon: "clock.fill")

                                LazyVGrid(
                                    columns: [GridItem(.adaptive(minimum: 95), spacing: 10)],
                                    spacing: 10
                                ) {
                                    ForEach(slots, id: \.self) { slot in
                                        TimeSlotButton(
                                            time: slot,
                                            isSelected: selectedSlot == slot
                                        ) { selectedSlot = slot }
                                    }
                                }
                            }
                        }

                        // ── Price Summary ─────────────────────────────
                        CFCard {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Test Fee")
                                        .font(.system(size: 12))
                                        .foregroundColor(.cfTextSecondary)
                                    Text("Rs. \(test.price)/=")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundColor(.cfBlue)
                                }
                                Spacer()
                                TagPill(text: "No hidden fees", color: .cfSuccess)
                            }
                        }

                        Spacer().frame(height: 100)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
            }

            // ── Bottom Bar ─────────────────────────────────────────────
            VStack(spacing: 0) {
                CFDivider()
                HStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(formattedDate)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.cfTextSecondary)
                        Text(selectedSlot)
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.cfTextPrimary)
                    }
                    PrimaryButton(title: "Proceed to Payment", icon: "lock.fill") {
                        nav.bookedDate = selectedDate
                        nav.bookedTime = selectedSlot
                        nav.showPayment = true
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.cfCard)
            }
        }
        .navigationBarHidden(true)
    }

    private var formattedDate: String {
        let f = DateFormatter()
        f.dateFormat = "EEE, d MMM"
        return f.string(from: selectedDate)
    }
}

