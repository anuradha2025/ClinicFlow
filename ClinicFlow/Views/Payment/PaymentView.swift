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

    init(billing: BillingInfo, doctor: Doctor) {
        _vm = StateObject(wrappedValue: PaymentViewModel(billing: billing, doctor: doctor))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // Card brand icons
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
                    FloatingLabelField(label: "Card Number",
                                       text: $vm.card.cardNumber,
                                       keyboardType: .numberPad)
                    HStack(spacing: 12) {
                        FloatingLabelField(label: "Month (MM)",
                                           text: $vm.card.expiryMonth,
                                           keyboardType: .numberPad)
                        FloatingLabelField(label: "Year (YY)",
                                           text: $vm.card.expiryYear,
                                           keyboardType: .numberPad)
                        FloatingLabelField(label: "CVV",
                                           text: $vm.card.cvv,
                                           isSecure: true)
                    }
                }
                .padding(.horizontal)

                // Billing Total
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

                // Pay Button
                Button {
                    vm.processPayment { showSuccess = true }
                } label: {
                    Text("Pay Now")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.cfPrimary)
                        .cornerRadius(12)
                }
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
