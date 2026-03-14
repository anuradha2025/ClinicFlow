import SwiftUI

struct ProceedPharmacyView: View {
    @ObservedObject var pharmVM: PharmacyViewModel
    let appointment: Appointment?
    @Environment(\.dismiss) var dismiss
    @State private var showPaymentAlert = false
    @State private var navigateToPayment = false

    private var medicines: [Medicine] {
        if let appointment, !appointment.prescription.isEmpty {
            return appointment.prescription.map { item in
                Medicine(
                    name: "\(item.name) \(item.dosage)",
                    quantity: 1,
                    price: price(for: item)
                )
            }
        }

        return [
            .init(name: "Amoxicillin 500mg", quantity: 1, price: 250),
            .init(name: "Paracetamol 500mg", quantity: 2, price: 120),
            .init(name: "Vitamin D 1000IU", quantity: 1, price: 180)
        ]
    }

    private var doctorName: String {
        appointment?.doctor.name ?? "Dr. Maya Patel"
    }

    private var totalAmount: Double {
        medicines.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
    }

    private func price(for item: PrescriptionItem) -> Double {
        let normalizedName = item.name.lowercased()

        if normalizedName.contains("paracetamol") {
            return 240
        }
        if normalizedName.contains("amoxicillin") {
            return 250
        }
        if normalizedName.contains("vitamin d") {
            return 180
        }
        if normalizedName.contains("vitamin c") {
            return 200
        }
        if normalizedName.contains("cetirizine") {
            return 160
        }
        if normalizedName.contains("salts") {
            return 230
        }

        return 200
    }

    var body: some View {
        ZStack {
            Color(red: 237/255, green: 241/255, blue: 1.0).ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Doctor Prescription")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                    Image(systemName: "chevron.left").opacity(0)
                }
                .padding(.horizontal, 20)
                .padding(.top, 56)
                .padding(.bottom, 16)
                .background(Color.white)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        // Doctor info
                        VStack(alignment: .leading, spacing: 8) {
                            Text(doctorName)
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                            Text("Prescription Summary")
                                .font(.system(size: 14, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)

                        // Medicine list
                        VStack(spacing: 0) {
                            ForEach(medicines) { item in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.name)
                                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                                        Text("Qty: \(item.quantity)")
                                            .font(.system(size: 12, design: .rounded))
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    Text("Rs. \(Int(item.price * Double(item.quantity)))")
                                        .font(.system(size: 14, weight: .bold, design: .rounded))
                                }
                                .padding(16)
                                .background(Color.white)

                                if item != medicines.last {
                                    Divider()
                                        .padding(.leading, 16)
                                }
                            }
                        }
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)

                        // Total
                        HStack {
                            Text("Total")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                            Spacer()
                            Text("Rs. \(Int(totalAmount))")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.05), radius: 6, x: 0, y: 4)

                        // Pay button
                        Button(action: {
                            showPaymentAlert = true
                        }) {
                            HStack {
                                Text("Place Order")
                                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                                Spacer()
                                Text("Rs. \(Int(totalAmount))")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(16)
                        }
                        .padding(.top, 8)
                        .padding(.bottom, 30)

                        // Navigation to payment page
                        NavigationLink(destination: PaymentView(pharmVM: pharmVM), isActive: $navigateToPayment) {
                            EmptyView()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            pharmVM.setPrescription(total: totalAmount, itemCount: medicines.reduce(0) { $0 + $1.quantity })
        }
        .alert("Order Placed", isPresented: $showPaymentAlert) {
            Button("Proceed to Payment") {
                navigateToPayment = true
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Your order has been placed. Proceed to payment to complete checkout.")
        }
    }
}

private struct Medicine: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let quantity: Int
    let price: Double
}

#Preview {
    NavigationStack {
        ProceedPharmacyView(pharmVM: PharmacyViewModel(), appointment: nil)
    }
}
