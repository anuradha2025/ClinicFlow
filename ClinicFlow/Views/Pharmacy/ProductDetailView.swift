
import SwiftUI

struct ProductDetailView: View {
    let product: Product
    @ObservedObject var pharmVM: PharmacyViewModel
    @State private var selectedVariant: String = ""
    @State private var quantity: Int = 1
    @State private var addedToCart = false
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            Color(red: 237/255, green: 241/255, blue: 1.0).ignoresSafeArea() // HEX EDF1FF

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Circle().fill(Color.white))
                        }
                        Spacer()
                        Text("Product details")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                        Spacer()
                        Button(action: { pharmVM.toggleWishlist(productId: product.id) }) {
                            Image(systemName: pharmVM.wishlist.contains(product.id) ? "heart.fill" : "heart")
                                .font(.system(size: 18))
                                .foregroundColor(pharmVM.wishlist.contains(product.id) ? .red : .gray)
                                .padding(10)
                                .background(Circle().fill(Color.white))
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 56)
                    .padding(.bottom, 16)

            
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                        VStack {
                            Image(systemName: product.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 140)
                                .foregroundColor(.orange)
                                .padding(24)

                            HStack(spacing: 6) {
                                ForEach(0..<3) { i in
                                    Circle()
                                        .fill(i == 0 ? Color.blue : Color(.systemGray4))
                                        .frame(width: 7, height: 7)
                                }
                            }
                            .padding(.bottom, 16)
                        }
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 220)

               
                    VStack(alignment: .leading, spacing: 16) {

                        // Name + Price
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.name)
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                Text(selectedVariant.isEmpty ? (product.variants.first ?? "") : selectedVariant)
                                    .font(.system(size: 13, design: .rounded))
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            VStack(alignment: .trailing, spacing: 2) {
                                Text("Rs. \(String(format: "%.0f", product.discountedPrice))")
                                    .font(.system(size: 18, weight: .bold, design: .rounded))
                                    .foregroundColor(.blue)
                                if product.discountPercent > 0 {
                                    Text("-\(product.discountPercent)%")
                                        .font(.system(size: 11, weight: .semibold))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 7).padding(.vertical, 3)
                                        .background(Capsule().fill(Color.blue))
                                }
                            }
                        }

     
                        Text(product.description)
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(.gray)
                            .lineSpacing(4)

            
                        Text("Select Variant")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))

                        FlowLayout(spacing: 8) {
                            ForEach(product.variants, id: \.self) { variant in
                                Button(action: { selectedVariant = variant }) {
                                    Text(variant)
                                        .font(.system(size: 12, design: .rounded))
                                        .foregroundColor(selectedVariant == variant ? .white : .black)
                                        .padding(.horizontal, 12).padding(.vertical, 7)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(selectedVariant == variant ? Color.blue : Color(.systemGray5))
                                        )
                                }
                            }
                        }

                        HStack {
                            Text("Quantity")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                            Spacer()
                            HStack(spacing: 16) {
                                Button(action: { if quantity > 1 { quantity -= 1 } }) {
                                    Image(systemName: "minus")
                                        .font(.system(size: 14, weight: .bold))
                                        .frame(width: 30, height: 30)
                                        .background(Circle().fill(Color(.systemGray5)))
                                }
                                Text("\(quantity)")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .frame(width: 24)
                                Button(action: { quantity += 1 }) {
                                    Image(systemName: "plus")
                                        .font(.system(size: 14, weight: .bold))
                                        .foregroundColor(.white)
                                        .frame(width: 30, height: 30)
                                        .background(Circle().fill(Color.blue))
                                }
                            }
                        }

                     
                        HStack {
                            Text("Rs. \(String(format: "%.0f", product.discountedPrice))")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            if product.discountPercent > 0 {
                                Text("-\(product.discountPercent)%")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 7).padding(.vertical, 3)
                                    .background(Capsule().fill(Color.blue))
                            }
                            Spacer()
                        }
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])
                    .padding(.top, 12)

                    Spacer().frame(height: 100)
                }
            }

            VStack(spacing: 0) {
                Divider()
                Button(action: {
                    let variant = selectedVariant.isEmpty ? (product.variants.first ?? "") : selectedVariant
                    for _ in 0..<quantity { pharmVM.addToCart(product: product, variant: variant) }
                    addedToCart = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { addedToCart = false }
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: addedToCart ? "checkmark.circle.fill" : "cart.fill")
                        Text(addedToCart ? "Added to Cart!" : "Add to Cart")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(RoundedRectangle(cornerRadius: 14).fill(addedToCart ? Color.green : Color.blue))
                    .padding(.horizontal, 20)
                    .animation(.easeInOut(duration: 0.3), value: addedToCart)
                }
                .padding(.vertical, 12)
                .background(Color.white)
            }
        }
        .navigationBarHidden(true)
        .onAppear { selectedVariant = product.variants.first ?? "" }
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(
            product: Product.sampleProducts[0],
            pharmVM: PharmacyViewModel()
        )
    }
    .environmentObject(AuthViewModel())
}
