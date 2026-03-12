//
//  LaboratoryView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import SwiftUI

struct LaboratoryView: View {
    @EnvironmentObject var nav: AppNavigation
    @State private var searchText    = ""
    @State private var selectedCat   = "All"

    let categories = ["All", "Diabetes", "Haematology", "Cardiology", "Endocrinology", "Gastroenterology"]

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
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 0) {

                            // Search
                            CFSearchBar(text: $searchText, placeholder: "Search tests, categories…")
                                .padding(.horizontal, 16)
                                .padding(.top, 16)

                            // Category Filter
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(categories, id: \.self) { cat in
                                        CategoryChip(label: cat, isSelected: selectedCat == cat) {
                                            withAnimation(.easeInOut(duration: 0.2)) {
                                                selectedCat = cat
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 14)
                            }

                            // Results count
                            HStack {
                                Text("\(filtered.count) test\(filtered.count == 1 ? "" : "s") available")
                                    .font(.system(size: 13))
                                    .foregroundColor(.cfTextSecondary)
                                Spacer()
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 10)

                            // Test List
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
            }
            .navigationTitle("Laboratory")
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
