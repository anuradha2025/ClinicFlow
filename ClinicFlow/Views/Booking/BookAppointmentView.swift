//
//  BookAppointmentView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct BookAppointmentView: View {
    @StateObject private var vm: BookAppointmentViewModel
    @State private var navigateToPayment = false
    @EnvironmentObject var appState: AppState

    init(doctor: Doctor) {
        _vm = StateObject(wrappedValue: BookAppointmentViewModel(doctor: doctor))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Doctor Summary
                DoctorSummaryCard(doctor: vm.doctor)
                    .padding(.horizontal)

                // Schedule Calendar
                VStack(alignment: .leading, spacing: 8) {
                    Text("Schedules")
                        .font(.headline)
                        .padding(.horizontal)

                    ScheduleCalendarView(selectedDate: $vm.selectedDate) { date in
                        vm.loadSlots(for: date)
                    }
                }

                // Time Slots
                VStack(alignment: .leading, spacing: 8) {
                    Text("Available Time Slots")
                        .font(.headline)
                        .padding(.horizontal)

                    TimeSlotPickerView(
                        slots: vm.availableSlots,
                        selected: $vm.selectedTimeSlot
                    )
                }

                // Billing Summary
                BillingSummaryView(billing: vm.billing)
                    .padding(.horizontal)

                // Book Button
                NavigationLink(destination: AppointmentPaymentView(billing: vm.billing, doctor: vm.doctor)) {
                    Text("Book Appointment")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(vm.selectedTimeSlot == nil ? Color.cfTextTertiary : Color.cfBlue)
                        .cornerRadius(16)
                        .shadow(color: vm.selectedTimeSlot == nil ? .clear : Color.cfBlue.opacity(0.30), radius: 8, x: 0, y: 4)
                        .contentShape(Rectangle())
                }
                .disabled(vm.selectedTimeSlot == nil)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.cfBg)
        .navigationTitle("Book Appointment")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.loadSlots(for: Date()) }
    }
}
