//
//  PreviousAppointmentDetailView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct PreviousAppointmentDetailView: View {
    let appointment: Appointment
    @EnvironmentObject var nav: AppNavigation

    var isCancelled: Bool {
        appointment.status == .cancelled
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                // Doctor Info Card
                AppointmentDoctorCard(appointment: appointment)
                    .padding(.horizontal)

                if isCancelled {
                    // Cancelled message
                    VStack(spacing: 10) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 44))
                            .foregroundColor(.cfDanger.opacity(0.6))
                        Text("Appointment Cancelled")
                            .font(.headline)
                            .foregroundColor(.cfTextPrimary)
                        Text("This appointment was cancelled. No reports or prescriptions are available.")
                            .font(.subheadline)
                            .foregroundColor(.cfTextSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 8)
                    .padding(.horizontal)

                } else {
                    // Prescription Section
                    if !appointment.prescription.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Prescription")
                                .font(.headline)

                            ForEach(appointment.prescription) { item in
                                HStack {
                                    Image(systemName: "pills.fill")
                                        .foregroundColor(.cfPrimary)
                                    Text(item.name)
                                        .font(.subheadline)
                                    Spacer()
                                    Text(item.dosage)
                                        .font(.subheadline.bold())
                                        .foregroundColor(.cfTextSecondary)
                                }
                                .padding(.vertical, 4)
                                if item.id != appointment.prescription.last?.id {
                                    Divider()
                                }
                            }

                            NavigationLink(destination: ProceedPharmacyView(pharmVM: PharmacyViewModel(), appointment: appointment)) {
                                HStack {
                                    Text("Proceed to Pharmacy")
                                        .font(.subheadline.bold())
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.cfPrimary)
                                .cornerRadius(10)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 8)
                        .padding(.horizontal)
                    }

                    // Lab Tests Section
                    if !appointment.labTests.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Lab Tests Required")
                                .font(.headline)

                            ForEach(appointment.labTests) { test in
                                HStack {
                                    Image(systemName: "testtube.2")
                                        .foregroundColor(.cfSuccess)
                                    Text(test.name)
                                        .font(.subheadline)
                                    Spacer()
                                }
                                .padding(.vertical, 4)
                                if test.id != appointment.labTests.last?.id {
                                    Divider()
                                }
                            }

                            Button {
                                nav.referralAppointment = appointment
                            } label: {
                                HStack {
                                    Text("Proceed to Laboratory")
                                        .font(.subheadline.bold())
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.cfSuccess)
                                .cornerRadius(10)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 8)
                        .padding(.horizontal)
                    }

                    // Downloads Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Downloads")
                            .font(.headline)

                        HStack(spacing: 12) {
                            Image(systemName: "doc.text.fill")
                                .foregroundColor(.cfDanger)
                                .font(.title2)

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Observation Report")
                                    .font(.subheadline.bold())
                                Text("PDF • 1.4 MB")
                                    .font(.caption)
                                    .foregroundColor(.cfTextSecondary)
                            }

                            Spacer()

                            Button {} label: {
                                Image(systemName: "arrow.down.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.cfPrimary)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.05), radius: 8)
                    .padding(.horizontal)
                }

                // Book Again Button — always visible
                NavigationLink(destination: BookAppointmentView(doctor: appointment.doctor)) {
                    Text(isCancelled ? "Book New Appointment" : "Book Again")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.cfPrimary)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.cfBg)
        .navigationTitle("Appointment Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
