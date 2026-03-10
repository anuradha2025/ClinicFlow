import SwiftUI

struct PaymentView: View {
    @ObservedObject var pharmVM: PharmacyViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showAddCard = false

    let paymentMethods = [
        ("Google Pay", "g.circle.fill", Color.blue),
        ("Apple Pay", "apple.logo", Color.black),
        ("Cash on delivery", "banknote.fill", Color.green)
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 0) {

                
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left").font(.system(size: 16, weight: .semibold)).foregroundColor(.black)
                    }
                    Spacer()
                    Text("Payment").font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                    Image(systemName: "chevron.left").opacity(0)
                }
                .padding(.horizontal, 20).padding(.top, 56).padding(.bottom, 16)
                .background(Color.white)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {

                        ProgressSteps(current: 2).padding(16).background(Color.white).cornerRadius(14)

                        VStack(alignment: .leading, spacing: 12) {
                            Text("Payment method").font(.system(size: 14, weight: .semibold, design: .rounded))

                            ForEach(pharmVM.savedCards) { card in
                                Button(action: { pharmVM.selectedPaymentMethod = card.id }) {
                                    HStack(spacing: 12) {
                                        Image(systemName: "creditcard.fill").foregroundColor(.blue)
                                            .frame(width: 36)
                                        Text("**** \(card.last4)").font(.system(size: 14, design: .rounded))
                                        Spacer()
                                        Button(action: {}) {
                                            Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                                        }
                                        ZStack {
                                            Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1.5).frame(width: 20, height: 20)
                                            if pharmVM.selectedPaymentMethod == card.id {
                                                Circle().fill(Color.blue).frame(width: 12, height: 12)
                                            }
                                        }
                                    }
                                    .padding(14).background(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(pharmVM.selectedPaymentMethod == card.id ? Color.blue : Color.clear, lineWidth: 1.5))
                                    .cornerRadius(12)
                                }
                            }

                           
                            Button(action: { pharmVM.selectedPaymentMethod = "pharmacy" }) {
                                HStack(spacing: 12) {
                                    Image(systemName: "cross.case.fill").foregroundColor(.blue).frame(width: 36)
                                    Text("At the pharm upon receiving").font(.system(size: 14, design: .rounded))
                                    Spacer()
                                    ZStack {
                                        Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1.5).frame(width: 20, height: 20)
                                        if pharmVM.selectedPaymentMethod == "pharmacy" {
                                            Circle().fill(Color.blue).frame(width: 12, height: 12)
                                        }
                                    }
                                }
                                .padding(14).background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(pharmVM.selectedPaymentMethod == "pharmacy" ? Color.blue : Color.clear, lineWidth: 1.5))
                                .cornerRadius(12)
                            }

                            ForEach(paymentMethods, id: \.0) { method in
                                Button(action: { pharmVM.selectedPaymentMethod = method.0 }) {
                                    HStack(spacing: 12) {
                                        Image(systemName: method.1).foregroundColor(method.2).frame(width: 36)
                                        Text(method.0).font(.system(size: 14, design: .rounded))
                                        Spacer()
                                        ZStack {
                                            Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1.5).frame(width: 20, height: 20)
                                            if pharmVM.selectedPaymentMethod == method.0 {
                                                Circle().fill(Color.blue).frame(width: 12, height: 12)
                                            }
                                        }
                                    }
                                    .padding(14).background(Color.white)
                                    .overlay(RoundedRectangle(cornerRadius: 12).stroke(pharmVM.selectedPaymentMethod == method.0 ? Color.blue : Color.clear, lineWidth: 1.5))
                                    .cornerRadius(12)
                                }
                            }

                          
                            Button(action: { showAddCard = true }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill").foregroundColor(.blue)
                                    Text("Add new card").font(.system(size: 14, weight: .semibold, design: .rounded)).foregroundColor(.blue)
                                }
                                .frame(maxWidth: .infinity).frame(height: 46)
                                .background(RoundedRectangle(cornerRadius: 12).stroke(Color.blue, style: StrokeStyle(lineWidth: 1.5, dash: [6])))
                            }
                        }
                        .padding(16).background(Color.white).cornerRadius(14)

                        Spacer().frame(height: 90)
                    }
                    .padding(.horizontal, 20).padding(.top, 12)
                }
            }

        
            VStack(spacing: 0) {
                Divider()
                NavigationLink(destination: OrderSuccessView(pharmVM: pharmVM)) {
                    HStack {
                        Text("1 Product").font(.system(size: 13, design: .rounded)).foregroundColor(.white.opacity(0.8))
                        Spacer()
                        Text("Rs. \(String(format: "%.0f", pharmVM.totalAmount))")
                            .font(.system(size: 14, weight: .bold, design: .rounded)).foregroundColor(.white)
                        Spacer()
                        Text("Pay").font(.system(size: 14, weight: .semibold, design: .rounded)).foregroundColor(.white)
                        Image(systemName: "lock.fill").font(.system(size: 13)).foregroundColor(.white)
                    }
                    .padding(.horizontal, 20).frame(height: 52).background(Color.blue)
                }
                .padding(.bottom, 8)
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showAddCard) {
            AddCardView(pharmVM: pharmVM)
        }
    }
}

#Preview {
    NavigationStack {
        PaymentView(pharmVM: PharmacyViewModel())
    }
    .environmentObject(AuthViewModel())
}
