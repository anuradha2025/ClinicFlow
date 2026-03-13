
import SwiftUI

struct OrderSuccessView: View {
    @ObservedObject var pharmVM: PharmacyViewModel
    @State private var scaleEffect: CGFloat = 0.5
    @State private var opacity: Double = 0

    var body: some View {
        ZStack {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 0) {

   
                HStack {
                    Spacer()
                    Text("Success").font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                }
                .padding(.horizontal, 20).padding(.top, 56).padding(.bottom, 16)
                .background(Color.white)

                ScrollView {
                    VStack(spacing: 20) {

                        ProgressSteps(current: 3).padding(16).background(Color.white).cornerRadius(14)

            
                        VStack(spacing: 20) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)).frame(height: 180)
                                VStack(spacing: 12) {
                                    ZStack {
                                        Circle().fill(Color.green.opacity(0.15)).frame(width: 80, height: 80)
                                        Circle().fill(Color.green).frame(width: 60, height: 60)
                                        Image(systemName: "checkmark").font(.system(size: 28, weight: .bold)).foregroundColor(.white)
                                    }
                                    .scaleEffect(scaleEffect)
                                    .opacity(opacity)
                                    Text("Successful").font(.system(size: 14, weight: .semibold, design: .rounded)).foregroundColor(.green)
                                }
                            }
                            Text("Your Order has been accepted")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .multilineTextAlignment(.center)
                        }
                        .padding(20).background(Color.white).cornerRadius(14)

                   
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Order Summary").font(.system(size: 14, weight: .semibold, design: .rounded))
                            SummaryRow(label: "Total Amount", value: "Rs. \(String(format: "%.0f", pharmVM.totalAmount))")
                            SummaryRow(label: "Delivery", value: pharmVM.selectedDeliveryMethod)
                            SummaryRow(label: "Payment", value: pharmVM.selectedPaymentMethod == "pharmacy" ? "At pharmacy" : pharmVM.selectedPaymentMethod)
                        }
                        .padding(16).background(Color.white).cornerRadius(14)

                        VStack(spacing: 12) {
                            NavigationLink(destination: PharmacyView()) {
                                Text("My Orders")
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundColor(.blue)
                                    .frame(maxWidth: .infinity).frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 14).stroke(Color.blue, lineWidth: 1.5))
                            }
                            NavigationLink(destination: PharmacyView()) {
                                Text("To the Dashboard")
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity).frame(height: 50)
                                    .background(RoundedRectangle(cornerRadius: 14).fill(Color.blue))
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .padding(.horizontal, 20).padding(.top, 12).padding(.bottom, 40)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            pharmVM.placeOrder()
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6).delay(0.3)) {
                scaleEffect = 1.0
                opacity = 1.0
            }
        }
    }
}

#Preview {
    NavigationStack {
        OrderSuccessView(pharmVM: PharmacyViewModel())
    }
    .environmentObject(AuthViewModel())
}
