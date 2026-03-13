//
//  LaboratoryView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

struct LaboratoryView: View {
    @EnvironmentObject var nav: AppNavigation
    @State private var searchText  = ""
    @State private var selectedCat = "All"
    @State private var pageTab     = 0

    let categories = ["All", "Diabetes", "Haematology", "Cardiology",
                      "Endocrinology", "Gastroenterology", "Urology"]

    var filtered: [LabTest] {
        sampleTests.filter { test in
            let matchCat  = selectedCat == "All" || test.category == selectedCat
            let matchText = searchText.isEmpty ||
                            test.name.localizedCaseInsensitiveContains(searchText) ||
                            test.category.localizedCaseInsensitiveContains(searchText)
            return matchCat && matchText
        }
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.cfBg.ignoresSafeArea()

                VStack(spacing: 0) {
                    if pageTab == 0 {
                        // Matches Doctors/Appointments style: content scrolls under the nav bar title
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 0) {
                                tabSwitcher
                                availableTestsContent
                            }
                        }
                        .transition(.opacity)
                    } else {
                        // Reports list with same top segmented control
                        tabSwitcher
                        MyReportsView()
                            .transition(.opacity)
                    }
                }
            }
            .navigationTitle("Laboratory")
        }
        .onAppear {
            if nav.showReportsTab {
                pageTab = 1
                nav.showReportsTab = false
            }
        }
        .onChange(of: nav.showReportsTab) { value in
            if value {
                pageTab = 1
                nav.showReportsTab = false
            }
        }
    }

    private var tabSwitcher: some View {
        HStack(spacing: 4) {
            PillTab(
                title: "Available Tests",
                count: filtered.count,
                isSelected: pageTab == 0
            ) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    pageTab = 0
                }
            }

            PillTab(
                title: "My Reports",
                count: sampleReports.count,
                isSelected: pageTab == 1
            ) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    pageTab = 1
                }
            }
        }
        .padding(4)
        .background(Color(red: 0.91, green: 0.91, blue: 0.93))
        .cornerRadius(14)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color.cfCard)
    }

    var availableTestsContent: some View {
        VStack(spacing: 0) {

                CFSearchBar(text: $searchText, placeholder: "Search tests, categories...")
                    .padding(.horizontal, 16)
                    .padding(.top, 16)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(categories, id: \.self) { cat in
                            CategoryChip(label: cat, isSelected: selectedCat == cat) {
                                withAnimation(.easeInOut(duration: 0.2)) { selectedCat = cat }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                }

                HStack {
                    Text("\(filtered.count) test\(filtered.count == 1 ? "" : "s") available")
                        .font(.system(size: 13))
                        .foregroundColor(.cfTextSecondary)
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 10)

                LazyVStack(spacing: 12) {
                    ForEach(filtered) { test in
                        TestListCard(test: test) {
                            nav.selectedTest = test
                        }
                    }
                    if filtered.isEmpty {
                        EmptyStateView(message: "No tests found for: " + searchText)
                            .padding(.top, 40)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 30)
            }
    }
}

// MARK: - Pill Tab
struct PillTab: View {
    let title:      String
    let count:      Int
    let isSelected: Bool
    let onTap:      () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Text(title)
                    .font(.system(size: 14, weight: isSelected ? .semibold : .medium))
                    .foregroundColor(isSelected ? .cfTextPrimary : .cfTextSecondary)
                Text("\(count)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(isSelected ? .white : .cfTextSecondary)
                    .frame(width: 22, height: 22)
                    .background(isSelected ? Color.cfBlue : Color(red: 0.80, green: 0.80, blue: 0.82))
                    .clipShape(Circle())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(isSelected ? Color.white : Color.clear)
            .cornerRadius(11)
            .shadow(color: isSelected ? Color.black.opacity(0.10) : .clear,
                    radius: 4, x: 0, y: 2)
        }
    }
}

// MARK: - Category Chip
struct CategoryChip: View {
    let label:      String
    let isSelected: Bool
    let onTap:      () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(label)
                .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .cfTextSecondary)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? Color.cfBlue : Color.cfCard)
                .cornerRadius(20)
                .shadow(color: isSelected ? Color.cfBlue.opacity(0.30) : Color.black.opacity(0.04),
                        radius: 5, x: 0, y: 2)
        }
    }
}

// MARK: - Empty State
struct EmptyStateView: View {
    let message: String
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 36))
                .foregroundColor(.cfTextTertiary)
            Text(message)
                .font(.system(size: 14))
                .foregroundColor(.cfTextSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }
}
