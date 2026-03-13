import SwiftUI

struct PaymentView: View {
    @ObservedObject var pharmVM: PharmacyViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showAddCard = false
    @State private var navigateToSuccess = false

    let paymentMethods = [
        ("Google Pay", "g.circle.fill", Color.blue),
        ("Apple Pay", "apple.logo", Color.black),
        ("Cash on delivery", "banknote.fill", Color.green)
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            RadialGradient(
                colors: [Color.blue.opacity(0.5), Color.white],
                center: .top,
                startRadius: 100,
                endRadius: 900
            )
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // Header + summary
                VStack(spacing: 20) {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Circle().fill(Color.black.opacity(0.25)))
                        }

                        Spacer()

                        Text("Checkout")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        Spacer()

                        Image(systemName: "cart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 56)

                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Order Summary")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)

                            Text("Review your items and choose a payment method")
                                .font(.system(size: 13, design: .rounded))
                                .foregroundColor(.white.opacity(0.85))
                                .lineLimit(2)
                        }

                        Spacer()

                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.25))
                                .frame(width: 52, height: 52)
                            Text("\(pharmVM.cartItems.count)")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 22)
                            .fill(Color.white.opacity(0.12))
                            .blur(radius: 0.8)
                    )
                    .padding(.horizontal, 20)
                }

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        // Payment Methods
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Choose payment method")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))

                            VStack(spacing: 12) {
                                // Saved cards
                                ForEach(pharmVM.savedCards) { card in
                                    Button(action: { pharmVM.selectedPaymentMethod = card.id }) {
                                        PaymentRow(
                                            iconName: "creditcard.fill",
                                            title: "**** \(card.last4)",
                                            isSelected: pharmVM.selectedPaymentMethod == card.id
                                        )
                                    }
                                }

                                // Add new card
                                Button(action: { showAddCard = true }) {
                                    HStack(spacing: 12) {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.blue)
                                            .frame(width: 36)
                                        Text("Add New Card")
                                            .font(.system(size: 14, design: .rounded))
                                            .foregroundColor(.blue)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding(14)
                                    .background(Color.blue.opacity(0.05))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                    )
                                    .cornerRadius(12)
                                }

                                // In-person
                                Button(action: { pharmVM.selectedPaymentMethod = "pharmacy" }) {
                                    PaymentRow(
                                        iconName: "cross.case.fill",
                                        title: "Pay at pharmacy",
                                        isSelected: pharmVM.selectedPaymentMethod == "pharmacy"
                                    )
                                }

                                // Other options
                                ForEach(paymentMethods, id: \.0) { method in
                                    Button(action: { pharmVM.selectedPaymentMethod = method.0 }) {
                                        PaymentRow(
                                            iconName: method.1,
                                            title: method.0,
                                            iconColor: method.2,
                                            isSelected: pharmVM.selectedPaymentMethod == method.0
                                        )
                                    }
                                }
                            }
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(18)
                            .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 10)
                        }

                        // Order total
                        VStack(spacing: 8) {
                            HStack {
                                Text("Total")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                Spacer()
                                Text("Rs. \(String(format: "%.0f", pharmVM.totalAmount))")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                            }

                            ProgressView(value: pharmVM.selectedPaymentMethod.isEmpty ? 0.5 : 1)
                                .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(18)
                        .shadow(color: Color.black.opacity(0.06), radius: 16, x: 0, y: 10)

                        Spacer().frame(height: 120)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }

            // Pay bottom bar
            VStack(spacing: 12) {
                Capsule()
                    .fill(Color.gray.opacity(0.25))
                    .frame(width: 48, height: 6)
                    .padding(.top, 6)

                Button(action: { navigateToSuccess = true }) {
                    HStack {
                        Text("Pay")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                        Spacer()
                        Text("Rs. \(String(format: "%.0f", pharmVM.totalAmount))")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .padding()
                    .background(pharmVM.selectedPaymentMethod.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(18)
                }
                .disabled(pharmVM.selectedPaymentMethod.isEmpty)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
                .navigationDestination(isPresented: $navigateToSuccess) {
                    OrderSuccessView(pharmVM: pharmVM)
                }
            }
            .background(
                Color.white.opacity(0.85)
                    .ignoresSafeArea(edges: .bottom)
            )
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showAddCard) {
            AddCardView(pharmVM: pharmVM)
        }
    }
}

// prescription info card
struct PrescriptionInfoCard: View {
    var total: Double
    var queueStatus: String

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)
            VStack(spacing: 12) {
                HStack {
                    Text("Prescription total")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    Spacer()
                    Text("Rs. \(Int(total))")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                }
                HStack {
                    Text("Queue")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                    Spacer()
                    Text(queueStatus)
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundColor(queueStatus == "Ready for pickup" ? .green : .orange)
                }
            }
            .padding(20)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - PaymentRow
struct PaymentRow: View {
    var iconName: String
    var title: String
    var iconColor: Color = .blue
    var isSelected: Bool

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
                .frame(width: 36)
            Text(title)
                .font(.system(size: 14, design: .rounded))
            Spacer()
            ZStack {
                Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                    .frame(width: 20, height: 20)
                if isSelected {
                    Circle().fill(Color.blue).frame(width: 12, height: 12)
                }
            }
        }
        .padding(14)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 1.5)
        )
        .cornerRadius(12)
    }
}
