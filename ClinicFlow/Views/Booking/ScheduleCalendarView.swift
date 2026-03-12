//
//  ScheduleCalendarView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct ScheduleCalendarView: View {
    @Binding var selectedDate: Date
    let onDateSelected: (Date) -> Void

    var next7Days: [Date] {
        (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: Date()) }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(next7Days, id: \.self) { date in
                    let isSelected = Calendar.current.isDate(selectedDate, inSameDayAs: date)
                    Button {
                        selectedDate = date
                        onDateSelected(date)
                    } label: {
                        VStack(spacing: 4) {
                            Text(date, format: .dateTime.weekday(.abbreviated))
                                .font(.caption)
                            Text(date, format: .dateTime.day())
                                .font(.headline.bold())
                        }
                        .padding(10)
                        .background(isSelected ? Color.cfBlue : Color.white)
                        .foregroundColor(isSelected ? .white : .cfTextPrimary)
                        .cornerRadius(10)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .accessibilityAddTraits(isSelected ? .isSelected : [])
                }
            }
            .padding(.horizontal)
        }
    }
}
