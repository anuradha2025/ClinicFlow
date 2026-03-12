//
//  PaymentView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct PaymentView: View {
    @StateObject private var vm: PaymentViewModel
    @State private var showSuccess = false
    @EnvironmentObject var appState: AppState

    init(billing: BillingInfo, doctor: Doctor) {
        _vm = StateObject(wrappedValue: PaymentViewModel(billing: billing, doctor: doctor))
    }

    // All fields must have at least 1 character
    var isFormValid: Bool {
        !vm.card.cardholderName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !vm.card.cardNumber.trimmingCharacters(in: .whitespaces).isEmpty &&
        !vm.card.expiryMonth.trimmingCharacters(in: .whitespaces).isEmpty &&
        !vm.card.expiryYear.trimmingCharacters(in: .whitespaces).isEmpty &&
        !vm.card.cvv.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // Header
                HStack(spacing: 16) {
                    Image(systemName: "creditcard.fill")
                        .font(.largeTitle)
                        .foregroundColor(.cfPrimary)
                    Text("Secure Payment")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)

                // Form Fields
                VStack(spacing: 16) {
                    FloatingLabelField(label: "Cardholder Name",
                                       text: $vm.card.cardholderName)
                        .textContentType(.name)

                    FloatingLabelField(label: "Card Number",
                                       text: $vm.card.cardNumber,
                                       keyboardType: .numberPad)
                        .textContentType(.creditCardNumber)

                    HStack(spacing: 12) {
                        FloatingLabelField(label: "Month (MM)",
                                           text: $vm.card.expiryMonth,
                                           keyboardType: .numberPad)
                            .textContentType(.none)
                        FloatingLabelField(label: "Year (YY)",
                                           text: $vm.card.expiryYear,
                                           keyboardType: .numberPad)
                            .textContentType(.none)
                        FloatingLabelField(label: "CVV",
                                           text: $vm.card.cvv,
                                           isSecure: true)
                            .textContentType(.none)
                    }
                }
                .padding(.horizontal)

                // Total Amount
                HStack {
                    Text("Total Amount").font(.headline)
                    Spacer()
                    Text("Rs. \(Int(vm.billing.total))")
                        .font(.title3.bold())
                        .foregroundColor(.cfPrimary)
                }
                .padding()
                .background(Color.cfPrimaryLight)
                .cornerRadius(12)
                .padding(.horizontal)

                // Pay Now Button — grayed out until form is valid
                Button {
                    vm.processPayment { showSuccess = true }
                } label: {
                    Text("Pay Now")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(isFormValid ? Color.cfPrimary : Color.gray.opacity(0.4))
                        .cornerRadius(12)
                }
                .disabled(!isFormValid)
                .padding(.horizontal)

                NavigationLink(
                    destination: PaymentSuccessView(doctor: vm.doctor, billing: vm.billing),
                    isActive: $showSuccess
                ) { EmptyView() }
            }
            .padding(.vertical)
        }
        .background(Color(.systemGray6))
        .navigationTitle("Payment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

