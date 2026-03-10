import SwiftUI

struct CartView: View {
    @ObservedObject var pharmVM: PharmacyViewModel
    @State private var navigateToDelivery = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(.systemGray6).ignoresSafeArea()

            VStack(spacing: 0) {


                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Cart")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                    Spacer()
                    ZStack(alignment: .topTrailing) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                        if pharmVM.cartCount > 0 {
                            Circle().fill(Color.blue).frame(width: 14, height: 14)
                                .overlay(Text("\(pharmVM.cartCount)").font(.system(size: 8, weight: .bold)).foregroundColor(.white))
                                .offset(x: 5, y: -5)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 56)
                .padding(.bottom, 16)
                .background(Color.white)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {

                 
                        HStack(spacing: 12) {
                            Image(systemName: "house.fill")
                                .foregroundColor(.blue)
                                .padding(8)
                                .background(Circle().fill(Color.blue.opacity(0.1)))
                            VStack(alignment: .leading, spacing: 2) {
                                HStack {
                                    Text("Home").font(.system(size: 14, weight: .semibold, design: .rounded))
                                    Spacer()
                                    Text("15 mins").font(.system(size: 11, design: .rounded)).foregroundColor(.gray)
                                }
                                Text("No 32, Doma Rd, Rajagiriya")
                                    .font(.system(size: 12, design: .rounded)).foregroundColor(.gray)
                            }
                        }
                        .padding(14)
                        .background(Color.white).cornerRadius(14)

           
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Item Details")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))

                            ForEach(pharmVM.cartItems) { item in
                                CartItemRow(item: item, pharmVM: pharmVM)
                            }
                        }
                        .padding(16)
                        .background(Color.white).cornerRadius(14)

                    
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Summary Details")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))

                            SummaryRow(label: "Price (\(pharmVM.cartItems.count) item\(pharmVM.cartItems.count == 1 ? "" : "s"))",
                                       value: "Rs. \(String(format: "%.0f", pharmVM.subtotal))")
                            if pharmVM.totalDiscount > 0 {
                                SummaryRow(label: "Discount",
                                           value: "-Rs. \(String(format: "%.0f", pharmVM.totalDiscount))",
                                           valueColor: .green)
                            }
                            SummaryRow(label: "Delivery Fee", value: "Free", valueColor: .green)
                            SummaryRow(label: "Platform Fee",
                                       value: "Rs. \(String(format: "%.0f", pharmVM.platformFee))")
                            Divider()
                            HStack {
                                Text("Total Amount")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                Spacer()
                                Text("Rs. \(String(format: "%.0f", pharmVM.totalAmount))")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                            }
                        }
                        .padding(16)
                        .background(Color.white).cornerRadius(14)

                        Spacer().frame(height: 90)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                }
            }

     
            VStack(spacing: 0) {
                Divider()
                NavigationLink(destination: DeliveryView(pharmVM: pharmVM)) {
                    HStack {
                        Text("1 Product")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(.white.opacity(0.8))
                        Spacer()
                        Text("Rs. \(String(format: "%.0f", pharmVM.totalAmount))")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        Spacer()
                        Text("Place your Order")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                        Image(systemName: "arrow.right")
                            .font(.system(size: 13))
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 52)
                    .background(Color.blue)
                }
                .disabled(pharmVM.cartItems.isEmpty)
                .padding(.bottom, 8)
            }
        }
        .navigationBarHidden(true)
    }
}

struct CartItemRow: View {
    let item: CartItem
    @ObservedObject var pharmVM: PharmacyViewModel

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(Color(.systemGray6)).frame(width: 56, height: 56)
                Image(systemName: item.product.imageName).resizable().scaledToFit()
                    .frame(width: 32, height: 32).foregroundColor(.orange)
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(item.product.name).font(.system(size: 13, weight: .semibold, design: .rounded)).lineLimit(1)
                Text(item.selectedVariant).font(.system(size: 11, design: .rounded)).foregroundColor(.gray)
                HStack(spacing: 6) {
                    Text("Rs. \(String(format: "%.0f", item.product.discountedPrice))")
                        .font(.system(size: 13, weight: .bold, design: .rounded))
                    if item.product.discountPercent > 0 {
                        Text("-\(item.product.discountPercent)%")
                            .font(.system(size: 10, weight: .semibold)).foregroundColor(.white)
                            .padding(.horizontal, 5).padding(.vertical, 2)
                            .background(Capsule().fill(Color.blue))
                    }
                }
            }
            Spacer()
            HStack(spacing: 10) {
                Button(action: { pharmVM.updateQuantity(item: item, delta: -1) }) {
                    Image(systemName: "minus").font(.system(size: 12, weight: .bold))
                        .frame(width: 26, height: 26).background(Circle().fill(Color(.systemGray5)))
                }
                Text("\(item.quantity)").font(.system(size: 14, weight: .bold, design: .rounded)).frame(width: 20)
                Button(action: { pharmVM.updateQuantity(item: item, delta: 1) }) {
                    Image(systemName: "plus").font(.system(size: 12, weight: .bold)).foregroundColor(.white)
                        .frame(width: 26, height: 26).background(Circle().fill(Color.blue))
                }
                Button(action: { pharmVM.removeFromCart(item: item) }) {
                    Image(systemName: "trash.fill").font(.system(size: 13)).foregroundColor(.red)
                        .frame(width: 26, height: 26).background(Circle().fill(Color.red.opacity(0.1)))
                }
            }
        }
    }
}

struct SummaryRow: View {
    let label: String; let value: String; var valueColor: Color = .black
    var body: some View {
        HStack {
            Text(label).font(.system(size: 13, design: .rounded)).foregroundColor(.gray)
            Spacer()
            Text(value).font(.system(size: 13, weight: .semibold, design: .rounded)).foregroundColor(valueColor)
        }
    }
}

#Preview {
    NavigationStack {
        CartView(pharmVM: PharmacyViewModel())
    }
    .environmentObject(AuthViewModel())
}
