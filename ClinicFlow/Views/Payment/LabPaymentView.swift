//
//  LabPaymentView.swift
//  ClinicFlow
//
//  Extracted from Thulani branch PaymentView for laboratory flow.
//

import SwiftUI

struct LabPaymentView: View {
    let test: LabTest
    @EnvironmentObject var nav: AppNavigation

    @State private var cardType       = 0
    @State private var cardholderName = ""
    @State private var cardNumber     = ""
    @State private var expMonth       = "01"
    @State private var expYear        = "2027"
    @State private var cvc            = ""
    @State private var isProcessing   = false
    @State private var errorMessage   = ""
    @State private var showError      = false

    let months = (1...12).map { String(format: "%02d", $0) }
    let years  = (2025...2032).map { "\($0)" }

    var isFormValid: Bool {
        !cardholderName.trimmingCharacters(in: .whitespaces).isEmpty &&
        cardNumber.filter({ $0.isNumber }).count == 16 &&
        cvc.count >= 3
    }

    var maskedNumber: String {
        let digits = cardNumber.filter { $0.isNumber }
        var result = ""
        for (i, ch) in digits.prefix(16).enumerated() {
            if i > 0 && i % 4 == 0 { result += " " }
            result.append(ch)
        }
        let remaining = max(0, 16 - digits.count)
        if result.count < 19 {
            if !result.isEmpty && result.count % 5 == 4 { result += " " }
        }
        if remaining > 0 {
            result += String(repeating: "•", count: remaining)
        }
        return result
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.cfBg.ignoresSafeArea()

            VStack(spacing: 0) {
                ScreenHeader(title: "Payment", onBack: { nav.showPayment = false })

                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16) {

                        // Card Type Selector
                        CFCard(padding: 12) {
                            HStack(spacing: 10) {
                                CardTypeTab(name: "VISA",
                                            icon: "v.circle.fill",
                                            isSelected: cardType == 0) { cardType = 0 }
                                CardTypeTab(name: "Mastercard",
                                            icon: "m.circle.fill",
                                            isSelected: cardType == 1) { cardType = 1 }
                            }
                        }

                        // Card Visual
                        ZStack {
                            RoundedRectangle(cornerRadius: 22)
                                .fill(
                                    LinearGradient(
                                        colors: cardType == 0
                                            ? [Color.cfBlue, Color.cfBlueDark]
                                            : [Color(red: 0.85, green: 0.20, blue: 0.20),
                                               Color(red: 0.60, green: 0.10, blue: 0.10)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(height: 190)
                                .shadow(color: (cardType == 0 ? Color.cfBlue : Color.cfDanger).opacity(0.42),
                                        radius: 18, x: 0, y: 10)

                            Circle()
                                .fill(Color.white.opacity(0.08))
                                .frame(width: 180, height: 180)
                                .offset(x: 100, y: -60)
                            Circle()
                                .fill(Color.white.opacity(0.05))
                                .frame(width: 120, height: 120)
                                .offset(x: -80, y: 60)

                            VStack(alignment: .leading, spacing: 14) {
                                HStack {
                                    Image(systemName: "creditcard.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white.opacity(0.85))
                                    Spacer()
                                    Text(cardType == 0 ? "VISA" : "MC")
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                }

                                Text(maskedNumber.isEmpty ? "•••• •••• •••• ••••" : maskedNumber)
                                    .font(.system(size: 17, weight: .medium, design: .monospaced))
                                    .foregroundColor(.white)
                                    .kerning(1.5)

                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("CARDHOLDER")
                                            .font(.system(size: 9))
                                            .foregroundColor(.white.opacity(0.6))
                                        Text(cardholderName.isEmpty ? "YOUR NAME" : cardholderName.uppercased())
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing, spacing: 2) {
                                        Text("EXPIRES")
                                            .font(.system(size: 9))
                                            .foregroundColor(.white.opacity(0.6))
                                        Text("\(expMonth)/\(expYear.suffix(2))")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding(22)
                        }

                        // Form Fields
                        CFCard {
                            VStack(spacing: 14) {
                                CFTextField(label: "Cardholder Name",
                                            placeholder: "John Doe",
                                            icon: "person.fill",
                                            text: $cardholderName)

                                CFTextField(label: "Card Number",
                                            placeholder: "1234 5678 9012 3456",
                                            icon: "creditcard.fill",
                                            text: $cardNumber,
                                            keyboard: .numberPad)

                                // Card number validation hint
                                if !cardNumber.isEmpty &&
                                    cardNumber.filter({ $0.isNumber }).count < 16 {
                                    HStack(spacing: 6) {
                                        Image(systemName: "exclamationmark.circle.fill")
                                            .font(.system(size: 12))
                                            .foregroundColor(.cfDanger)
                                        Text("\(cardNumber.filter({ $0.isNumber }).count)/16 digits entered")
                                            .font(.system(size: 11))
                                            .foregroundColor(.cfDanger)
                                    }
                                    .padding(.leading, 4)
                                }

                                HStack(spacing: 12) {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Exp Month")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.cfTextSecondary)
                                        Picker("", selection: $expMonth) {
                                            ForEach(months, id: \.self) { Text($0) }
                                        }
                                        .pickerStyle(.menu)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(Color.cfBg)
                                        .cornerRadius(13)
                                    }

                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("Exp Year")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundColor(.cfTextSecondary)
                                        Picker("", selection: $expYear) {
                                            ForEach(years, id: \.self) { Text($0) }
                                        }
                                        .pickerStyle(.menu)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(Color.cfBg)
                                        .cornerRadius(13)
                                    }

                                    CFTextField(label: "CVC",
                                                placeholder: "•••",
                                                icon: "lock.fill",
                                                text: $cvc,
                                                keyboard: .numberPad,
                                                isSecure: true)
                                }
                            }
                        }

                        // Order Summary
                        CFCard {
                            VStack(spacing: 10) {
                                SummaryRow(label: "Test Fee",    value: "Rs. \(test.price)")
                                SummaryRow(label: "Booking Fee", value: "Free")
                                CFDivider()
                                HStack {
                                    Text("Total")
                                        .font(.system(size: 15, weight: .bold))
                                        .foregroundColor(.cfTextPrimary)
                                    Spacer()
                                    Text("Rs. \(test.price)/=")
                                        .font(.system(size: 17, weight: .bold))
                                        .foregroundColor(.cfBlue)
                                }
                            }
                        }

                        Spacer().frame(height: 100)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                }
            }

            // Bottom Bar
            VStack(spacing: 0) {
                CFDivider()
                PrimaryButton(
                    title: isProcessing ? "Processing..." : "Pay Rs. \(test.price)/=",
                    icon: isProcessing ? nil : "lock.shield.fill",
                    color: isFormValid ? .cfBlue : .cfTextTertiary
                ) {
                    guard !isProcessing else { return }

                    // Validation
                    guard !cardholderName.trimmingCharacters(in: .whitespaces).isEmpty else {
                        errorMessage = "Please enter cardholder name"
                        showError = true
                        return
                    }
                    guard cardNumber.filter({ $0.isNumber }).count == 16 else {
                        errorMessage = "Please enter a valid 16-digit card number"
                        showError = true
                        return
                    }
                    guard cvc.count >= 3 else {
                        errorMessage = "Please enter a valid CVC (3 digits)"
                        showError = true
                        return
                    }

                    isProcessing = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        isProcessing = false
                        nav.showSuccess = true
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.cfCard)
            }
        }
        .navigationBarHidden(true)
        .alert("Invalid Details", isPresented: $showError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}
