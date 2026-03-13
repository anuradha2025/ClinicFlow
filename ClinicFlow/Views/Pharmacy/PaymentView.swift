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
            Color(red: 237/255, green: 241/255, blue: 1.0).ignoresSafeArea() // HEX EDF1FF

            VStack(spacing: 0) {

                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Payment")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                    Image(systemName: "chevron.left").opacity(0)
                }
                .padding(.horizontal, 20)
                .padding(.top, 56)
                .padding(.bottom, 16)
                .background(Color.white)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {

                        ProgressSteps(current: 2)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(14)

                        // Payment Methods Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Payment method")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))

                            // Saved Cards
                            ForEach(pharmVM.savedCards) { card in
                                Button(action: { pharmVM.selectedPaymentMethod = card.id }) {
                                    PaymentRow(
                                        iconName: "creditcard.fill",
                                        title: "**** \(card.last4)",
                                        isSelected: pharmVM.selectedPaymentMethod == card.id
                                    )
                                }
                            }

                            // At pharmacy
                            Button(action: { pharmVM.selectedPaymentMethod = "pharmacy" }) {
                                PaymentRow(
                                    iconName: "cross.case.fill",
                                    title: "At the pharm upon receiving",
                                    isSelected: pharmVM.selectedPaymentMethod == "pharmacy"
                                )
                            }

                            // Other methods
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

                            // Add new card
                            Button(action: { showAddCard = true }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill").foregroundColor(.blue)
                                    Text("Add new card")
                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        .foregroundColor(.blue)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 1.5, dash: [6]))
                                )
                            }

                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(14)

                        Spacer().frame(height: 90)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                }
            }

            // Pay Button
            VStack(spacing: 0) {
                Divider()

                Button(action: { navigateToSuccess = true }) {
                    HStack {
                        Text("\(pharmVM.cartItems.count) Product\(pharmVM.cartItems.count > 1 ? "s" : "")")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                        Spacer()
                        Text("Rs. \(String(format: "%.0f", pharmVM.totalAmount))")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                        Text("Pay")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                        Image(systemName: "lock.fill")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 52)
                    .background(pharmVM.selectedPaymentMethod.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(16)
                }
                .disabled(pharmVM.selectedPaymentMethod.isEmpty)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                .navigationDestination(isPresented: $navigateToSuccess) {
                    OrderSuccessView(pharmVM: pharmVM)
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showAddCard) {
            AddCardView(pharmVM: pharmVM)
        }
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
