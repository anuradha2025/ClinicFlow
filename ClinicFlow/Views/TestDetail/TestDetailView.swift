//
//  TestDetailView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

struct TestDetailView: View {
    let test: LabTest
    @EnvironmentObject var nav: AppNavigation
    @State private var appear = false

    var categoryColor: Color {
        switch test.category {
        case "Diabetes":        return .cfBlue
        case "Haematology":     return .cfDanger
        case "Cardiology":      return Color(red: 0.95, green: 0.35, blue: 0.35)
        case "Endocrinology":   return .cfPurple
        case "Gastroenterology": return .cfWarning
        case "Urology": return Color(red: 0.96, green: 0.65, blue: 0.14)
        default:                return .cfBlue
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.cfBg.ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {

                    // ── Hero ────────────────────────────────────────────
                    ZStack(alignment: .top) {
                        // Gradient background
                        Rectangle()
                            .fill(
                                LinearGradient(
                                    colors: [categoryColor.opacity(0.18), categoryColor.opacity(0.04)],
                                    startPoint: .topLeading, endPoint: .bottomTrailing
                                )
                            )
                            .frame(height: 260)

                        // Decorative blobs
                        Circle()
                            .fill(categoryColor.opacity(0.10))
                            .frame(width: 220, height: 220)
                            .offset(x: 120, y: -60)
                        Circle()
                            .fill(categoryColor.opacity(0.07))
                            .frame(width: 140, height: 140)
                            .offset(x: -80, y: 100)

                        // Centre icon
                        VStack {
                            Spacer().frame(height: 110)
                            ZStack {
                                Circle()
                                    .fill(categoryColor.opacity(0.15))
                                    .frame(width: 110, height: 110)
                                Circle()
                                    .fill(categoryColor.opacity(0.22))
                                    .frame(width: 80, height: 80)
                                Image(systemName: test.iconName)
                                    .font(.system(size: 42, weight: .light))
                                    .foregroundColor(categoryColor)
                            }
                            .scaleEffect(appear ? 1 : 0.6)
                            .opacity(appear ? 1 : 0)
                        }

                        // Back button
                        HStack {
                            Button { nav.selectedTest = nil } label: {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.cfTextPrimary)
                                    .frame(width: 40, height: 40)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                            Spacer()
                            // Bookmark
                            Button { } label: {
                                Image(systemName: "bookmark")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.cfTextPrimary)
                                    .frame(width: 40, height: 40)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 58)
                    }
                    .ignoresSafeArea(edges: .top)

                    // ── Content Card ────────────────────────────────────
                    VStack(alignment: .leading, spacing: 20) {

                        // Title row
                        HStack(alignment: .top, spacing: 12) {
                            VStack(alignment: .leading, spacing: 6) {
                                TagPill(text: test.category, color: categoryColor)
                                Text(test.name)
                                    .font(.system(size: 21, weight: .bold))
                                    .foregroundColor(.cfTextPrimary)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("Rs. \(test.price)/=")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(categoryColor)
                                HStack(spacing: 4) {
                                    Image(systemName: "clock")
                                        .font(.system(size: 10))
                                    Text(test.duration)
                                        .font(.system(size: 11))
                                }
                                .foregroundColor(.cfTextSecondary)
                            }
                        }

                        CFDivider()

                        // Quick stats row
                        HStack(spacing: 0) {
                            QuickStat(icon: "building.2.fill", label: "Location", value: "Main Lab", color: categoryColor)
                            Divider().frame(height: 40)
                            QuickStat(icon: "clock.fill", label: "Duration", value: test.duration, color: categoryColor)
                            Divider().frame(height: 40)
                            QuickStat(icon: "person.fill.checkmark", label: "Fasting", value: "Required", color: categoryColor)
                        }
                        .padding(.vertical, 8)
                        .background(categoryColor.opacity(0.05))
                        .cornerRadius(14)

                        // About
                        VStack(alignment: .leading, spacing: 8) {
                            SectionLabel(text: "About this Test", icon: "info.circle.fill")
                            Text(test.description)
                                .font(.system(size: 14))
                                .foregroundColor(.cfTextSecondary)
                                .lineSpacing(5)
                        }

                        CFDivider()

                        // Before the Test
                        VStack(alignment: .leading, spacing: 12) {
                            SectionLabel(text: "Before the Test", icon: "checklist")

                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(Array(test.beforeTest.enumerated()), id: \.offset) { idx, item in
                                    HStack(alignment: .top, spacing: 12) {
                                        ZStack {
                                            Circle()
                                                .fill(categoryColor)
                                                .frame(width: 24, height: 24)
                                            Text("\(idx + 1)")
                                                .font(.system(size: 11, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                        Text(item)
                                            .font(.system(size: 13))
                                            .foregroundColor(.cfTextPrimary)
                                            .lineSpacing(3)
                                            .fixedSize(horizontal: false, vertical: true)
                                    }
                                }
                            }
                            .padding(16)
                            .background(categoryColor.opacity(0.05))
                            .cornerRadius(16)
                        }

                        // Spacer for bottom bar
                        Spacer().frame(height: 100)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 22)
                }
            }

            // ── Fixed Bottom Bar ───────────────────────────────────────
            VStack(spacing: 0) {
                CFDivider()
                HStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Total")
                            .font(.system(size: 11))
                            .foregroundColor(.cfTextSecondary)
                        Text("Rs. \(test.price)/=")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(categoryColor)
                    }
                    PrimaryButton(title: "Book Test", icon: "calendar.badge.plus", color: categoryColor) {
                        nav.showBooking = true
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.cfCard)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.65).delay(0.1)) {
                appear = true
            }
        }
    }
}

// MARK: - Quick Stat Cell
struct QuickStat: View {
    let icon:  String
    let label: String
    let value: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14))
                .foregroundColor(color)
            Text(value)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.cfTextPrimary)
            Text(label)
                .font(.system(size: 10))
                .foregroundColor(.cfTextSecondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
    }
}
