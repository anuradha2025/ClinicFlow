import SwiftUI

struct PharmacyView: View {
    var showsBackButton: Bool = true
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
            Color(red: 237/255, green: 241/255, blue: 1.0).ignoresSafeArea() // HEX EDF1FF

            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {

                    VStack(spacing: 0) {

                        // MARK: Header
                        HStack {
                            Group {
                                if showsBackButton {
                                    Button(action: { dismiss() }) {
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.black)
                                            .padding(10)
                                            .background(Circle().fill(Color.white))
                                    }
                                } else {
                                    Color.clear
                                        .frame(width: 36, height: 36)
                                }
                            }
                            Spacer()
                            Text("Pharmacy")
                                .font(.system(size: 34, weight: .bold, design: .rounded))
                            Spacer()
                            NavigationLink(destination: CartView(pharmVM: pharmVM)) {
                                ZStack(alignment: .topTrailing) {
                                    Image(systemName: "cart.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.blue)
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

                        // MARK: Search Bar
                        HStack(spacing: 10) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                            TextField("Search", text: $pharmVM.searchText)
                                .font(.system(size: 15, design: .rounded))
                            Spacer()
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(Color(red: 237/255, green: 241/255, blue: 1.0)) // HEX EDF1FF
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        .padding(.top, 12)
                        .padding(.bottom, 16)
                    }
                    .background(Color.white)
                    .cornerRadius(16)

                       

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

                            HStack(alignment: .top, spacing: 4) {
                                ForEach(Product.categories, id: \.self) { cat in
                                    Button(action: {
                                        pharmVM.selectedCategory = pharmVM.selectedCategory == cat ? "All" : cat
                                    }) {
                                        VStack(spacing: 8) {
                                            ZStack {
                                                Circle()
                                                    .fill(
                                                        pharmVM.selectedCategory == cat
                                                        ? Color.blue.opacity(0.12)
                                                        : Color(.systemGray5)
                                                    )
                                                    .frame(width: 50, height: 50)
                                                Image(systemName: categoryIcons[cat] ?? "pills")
                                                    .font(.system(size: 18))
                                                    .foregroundColor(
                                                        pharmVM.selectedCategory == cat ? .blue : .secondary
                                                    )
                                            }

                                            Text(cat)
                                                .font(.system(size: 10, weight: .medium, design: .rounded))
                                                .foregroundColor(
                                                    pharmVM.selectedCategory == cat ? .blue : .black.opacity(0.75)
                                                )
                                                .multilineTextAlignment(.center)
                                                .lineLimit(2)
                                                .minimumScaleFactor(0.9)
                                                .frame(maxWidth: .infinity)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .animation(.spring(), value: pharmVM.selectedCategory)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.vertical, 10)
                        }
                        .padding(16)
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
                                columns: [
                                    GridItem(.flexible(), spacing: 16),
                                    GridItem(.flexible(), spacing: 16)
                                ],
                                spacing: 16
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
                                    .padding(4)
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
                        .fill(Color(red: 237/255, green: 241/255, blue: 1.0)) // HEX EDF1FF
                        .frame(height: 110)
                    Image(systemName: product.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
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

// MARK: Featured Product Card (slider style)
struct FeaturedProductCard: View {
    let product: Product

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [Color.blue.opacity(0.9), Color.purple.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 8)

            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Featured")
                        .font(.system(size: 11, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.white.opacity(0.8))
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.15))
                        )

                    Text(product.name)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .lineLimit(2)

                    Text(product.description)
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(Color.white.opacity(0.8))
                        .lineLimit(2)

                    HStack(spacing: 6) {
                        Text("Rs. \(Int(product.discountedPrice))")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.white)

                        if product.discountPercent > 0 {
                            Text("-\(product.discountPercent)%")
                                .font(.system(size: 11, weight: .semibold, design: .rounded))
                                .foregroundColor(.blue)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Capsule().fill(Color.white))
                        }
                    }
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white.opacity(0.18))
                        .frame(width: 90, height: 90)
                    Image(systemName: product.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 55, height: 55)
                        .foregroundColor(.white)
                }
            }
            .padding(20)
        }
    }
}

// MARK: Preview
#Preview {
    NavigationStack {
        PharmacyView()
    }
    .environmentObject(AuthViewModel())
}
