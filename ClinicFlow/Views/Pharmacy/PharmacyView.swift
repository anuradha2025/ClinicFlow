import SwiftUI

struct PharmacyView: View {
    @StateObject var pharmVM = PharmacyViewModel()
    @Environment(\.dismiss) var dismiss

    let categoryIcons = [
        "Vitamins": "pills.fill",
        "Beauty and care": "sparkles",
        "Medicines": "cross.case.fill",
        "Sport and health": "figure.run"
    ]

    var body: some View {
        ZStack(alignment: .top) {
            Color(.systemGray6).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    // MARK: Header
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                                .padding(10)
                                .background(Circle().fill(Color.white))
                        }
                        Spacer()
                        Text("Pharmacy")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                        Spacer()
                        NavigationLink(destination: CartView(pharmVM: pharmVM)) {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "cart.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                if pharmVM.cartCount > 0 {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 16, height: 16)
                                        .overlay(
                                            Text("\(pharmVM.cartCount)")
                                                .font(.system(size: 9, weight: .bold))
                                                .foregroundColor(.white)
                                        )
                                        .offset(x: 6, y: -6)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 56)
                    .padding(.bottom, 16)
                    .background(Color.white)

                    // MARK: Search Bar
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $pharmVM.searchText)
                            .font(.system(size: 15, design: .rounded))
                        Spacer()
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.white)

                    VStack(spacing: 16) {

                        // MARK: Categories
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Categories")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                Spacer()
                                Button("See all") {}
                                    .font(.system(size: 14))
                                    .foregroundColor(.blue)
                            }

                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(Product.categories, id: \.self) { cat in
                                        Button(action: {
                                            pharmVM.selectedCategory = pharmVM.selectedCategory == cat ? "All" : cat
                                        }) {
                                            VStack(spacing: 8) {
                                                ZStack {
                                                    Circle()
                                                        .fill(pharmVM.selectedCategory == cat ? Color.blue.opacity(0.2) : Color(.systemGray5))
                                                        .frame(width: 60, height: 60)
                                                    Image(systemName: categoryIcons[cat] ?? "pills")
                                                        .font(.system(size: 22))
                                                        .foregroundColor(pharmVM.selectedCategory == cat ? .blue : .gray)
                                                }
                                                Text(cat)
                                                    .font(.system(size: 12))
                                                    .foregroundColor(.gray)
                                                    .frame(width: 70)
                                                    .multilineTextAlignment(.center)
                                            }
                                            .animation(.spring(), value: pharmVM.selectedCategory)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .frame(alignment: .center)
                            }
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(16)

                        // MARK: Prescription Section
                        HStack(spacing: 12) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.orange.opacity(0.15))
                                    .frame(width: 40, height: 40)
                                Image(systemName: "doc.text.fill")
                                    .foregroundColor(.orange)
                            }
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Order Via Prescription")
                                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                                Text("Upload your prescription easily")
                                    .font(.system(size: 11, design: .rounded))
                                    .foregroundColor(.gray)
                                    .lineLimit(2)
                            }
                            Spacer()
                            Image(systemName: "arrow.down.circle.fill")
                                .font(.system(size: 22))
                                .foregroundColor(.blue)
                        }
                        .padding(14)
                        .background(Color.white)
                        .cornerRadius(16)

                        // MARK: Suggested Products
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Suggest Product")
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                Spacer()
                                Button("See all") {}
                                    .font(.system(size: 13))
                                    .foregroundColor(.blue)
                            }

                            LazyVGrid(
                                columns: [GridItem(.flexible()), GridItem(.flexible())],
                                spacing: 12
                            ) {
                                ForEach(pharmVM.filteredProducts) { product in
                                    NavigationLink(
                                        destination: ProductDetailView(
                                            product: product,
                                            pharmVM: pharmVM
                                        )
                                    ) {
                                        ProductCard(product: product, pharmVM: pharmVM)
                                    }
                                }
                            }
                        }
                        .padding(16)
                        .background(Color.white)
                        .cornerRadius(16)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: Product Card
struct ProductCard: View {
    let product: Product
    @ObservedObject var pharmVM: PharmacyViewModel
    @State private var heartScale: CGFloat = 1.0

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .frame(height: 110)
                    Image(systemName: product.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.orange)
                }

                // Heart Button with Animation
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) {
                        pharmVM.toggleWishlist(productId: product.id)
                        heartScale = 1.5
                    }
                    withAnimation(.spring().delay(0.2)) {
                        heartScale = 1.0
                    }
                }) {
                    Image(systemName: pharmVM.wishlist.contains(product.id) ? "heart.fill" : "heart")
                        .font(.system(size: 14))
                        .foregroundColor(pharmVM.wishlist.contains(product.id) ? .red : .gray)
                        .scaleEffect(heartScale)
                        .padding(6)
                        .background(Circle().fill(Color.white))
                }
                .padding(6)
            }

            Text(product.name)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(.black)
                .lineLimit(1)

            Text(product.variants.first ?? "")
                .font(.system(size: 10, design: .rounded))
                .foregroundColor(.gray)

            HStack(spacing: 4) {
                Text("Rs. \(Int(product.discountedPrice))")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                if product.discountPercent > 0 {
                    Text("-\(product.discountPercent)%")
                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(Color.blue))
                }
            }

            Text("\(product.soldCount) sold")
                .font(.system(size: 10, design: .rounded))
                .foregroundColor(.gray)
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: Preview
#Preview {
    NavigationStack {
        PharmacyView()
    }
    .environmentObject(AuthViewModel())
}
