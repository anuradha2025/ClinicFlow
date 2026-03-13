import SwiftUI

struct DeliveryView: View {
    @ObservedObject var pharmVM: PharmacyViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showPayment = false

    let deliveryMethods = [
        ("Pickup from the pharm", "figure.walk"),
        ("Delivery to the post office", "building.columns.fill"),
        ("Delivery by courier", "bicycle")
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 0) {
                // MARK: Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Delivery")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                    Image(systemName: "chevron.left").opacity(0)
                }
                .padding(.horizontal, 20)
                .padding(.top, 56)
                .padding(.bottom, 16)
                .background(Color.white)

                // MARK: Scrollable Content
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {

                        ProgressSteps(current: 1)
                            .padding(16)
                            .background(Color.white)
                            .cornerRadius(14)

                        // Pharmacy Info
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Pharmacy")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                            HStack(spacing: 12) {
                                Image(systemName: "cross.case.fill")
                                    .foregroundColor(.blue)
                                    .padding(10)
                                    .background(Circle().fill(Color.blue.opacity(0.1)))
                                VStack(alignment: .leading, spacing: 3) {
                                    HStack {
                                        Text("ABC Pharmacy")
                                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        Spacer()
                                        Text("0.5 km")
                                            .font(.system(size: 11, weight: .semibold))
                                            .foregroundColor(.white)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 3)
                                            .background(Capsule().fill(Color.green))
                                    }
                                    Label("MediQueue Hospital, Colombo 07", systemImage: "mappin.circle.fill")
                                        .font(.system(size: 11, design: .rounded))
                                        .foregroundColor(.gray)
                                    Label("Daily 8:00 am – 22:00pm", systemImage: "clock.fill")
                                        .font(.system(size: 11, design: .rounded))
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(14)

                        // Delivery Methods
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Delivery method")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))

                            ForEach(deliveryMethods, id: \.0) { method in
                                Button(action: { pharmVM.selectedDeliveryMethod = method.0 }) {
                                    HStack(spacing: 12) {
                                        Image(systemName: method.1)
                                            .font(.system(size: 18))
                                            .foregroundColor(.blue)
                                            .frame(width: 40)
                                        Text(method.0)
                                            .font(.system(size: 14, design: .rounded))
                                            .foregroundColor(.black)
                                        Spacer()
                                        ZStack {
                                            Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1.5)
                                                .frame(width: 20, height: 20)
                                            if pharmVM.selectedDeliveryMethod == method.0 {
                                                Circle().fill(Color.blue).frame(width: 12, height: 12)
                                            }
                                        }
                                    }
                                    .padding(14)
                                    .background(Color.white)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(pharmVM.selectedDeliveryMethod == method.0 ? Color.blue : Color.clear, lineWidth: 1.5)
                                    )
                                    .cornerRadius(12)
                                }
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

            // MARK: Continue Button
            VStack(spacing: 0) {
                Divider()

                Button(action: { showPayment = true }) {
                    HStack {
                        Text("\(pharmVM.cartItems.count) Product\(pharmVM.cartItems.count > 1 ? "s" : "")")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                        Spacer()
                        Text("Rs. \(String(format: "%.0f", pharmVM.totalAmount))")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                        Text("Continue")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 52)
                    .background(pharmVM.selectedDeliveryMethod.isEmpty ? Color.gray : Color.blue)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y: 3)
                }
                .disabled(pharmVM.selectedDeliveryMethod.isEmpty)
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                // Modern navigationDestination API
                .navigationDestination(isPresented: $showPayment) {
                    PaymentView(pharmVM: pharmVM)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: Progress Steps
struct ProgressSteps: View {
    let current: Int
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<3) { i in
                ZStack {
                    Circle()
                        .fill(i <= current ? Color.blue : Color(.systemGray4))
                        .frame(width: 32, height: 32)
                    Image(systemName: i == 0 ? "mappin.circle.fill" : i == 1 ? "shippingbox.fill" : "checkmark.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                }
                if i < 2 {
                    Rectangle()
                        .fill(i < current ? Color.blue : Color(.systemGray4))
                        .frame(height: 2)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

// MARK: Preview
#Preview {
    NavigationStack {
        DeliveryView(pharmVM: PharmacyViewModel())
    }
    .environmentObject(AuthViewModel())
}
