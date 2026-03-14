//
//  DoctorProfileView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct DoctorProfileView: View {
    let doctor: Doctor
    @State private var navigateToBook = false
    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // Header Card
                VStack(spacing: 12) {
                    DoctorAvatarView(imageName: doctor.imageName, size: 90)

                    Text(doctor.name)
                        .font(.title2.bold())
                    Text(doctor.specialty)
                        .foregroundColor(.cfTextSecondary)
                    StarRatingView(rating: doctor.rating)
                    Text("\(doctor.reviewCount) reviews")
                        .font(.caption)
                        .foregroundColor(.cfTextSecondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)

                // Stats Row
                HStack(spacing: 0) {
                    StatItem(value: "\(doctor.experience)", label: "Years Exp.")
                    Divider().frame(height: 40)
                    StatItem(value: "\(doctor.patientCount)+", label: "Patients")
                    Divider().frame(height: 40)
                    StatItem(value: String(format: "%.1f", doctor.rating), label: "Rating")
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)

                // Biography
                VStack(alignment: .leading, spacing: 8) {
                    Text("Doctor Biography")
                        .font(.headline)
                    Text(doctor.biography)
                        .font(.subheadline)
                        .foregroundColor(.cfTextSecondary)
                        .lineSpacing(4)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)

                // Charge
                HStack {
                    Text("Consultation Fee")
                        .foregroundColor(.cfTextSecondary)
                    Spacer()
                    Text("Rs. \(Int(doctor.chargeAmount))")
                        .font(.headline)
                        .foregroundColor(.cfPrimary)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .padding(.horizontal)

                // Book Button
                NavigationLink(destination: BookAppointmentView(doctor: doctor)) {
                    Text("Book Appointment")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.cfBlue)
                        .cornerRadius(16)
                        .shadow(color: Color.cfBlue.opacity(0.30), radius: 8, x: 0, y: 4)
                        .contentShape(Rectangle())
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color.cfBg)
        .navigationTitle(doctor.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StatItem: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 4) {
            Text(value).font(.headline.bold()).foregroundColor(.cfPrimary)
            Text(label).font(.caption).foregroundColor(.cfTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}
