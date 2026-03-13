import Foundation
import Combine

class PharmacyViewModel: ObservableObject {
    @Published var products: [Product] = Product.sampleProducts
    @Published var cartItems: [CartItem] = []
    @Published var wishlist: Set<String> = []
    @Published var searchText: String = ""
    @Published var selectedCategory: String = "All"


    @Published var selectedDeliveryMethod: String = "Pickup from the pharm"

    // Payment
    @Published var selectedPaymentMethod: String = "card"
    @Published var savedCards: [SavedCard] = [
        SavedCard(last4: "3957", brand: "Visa")
    ]


    @Published var orderPlaced: Bool = false

    var filteredProducts: [Product] {
        var list = products
        if selectedCategory != "All" {
            let categoryToMatch: String
            // Map display category names to actual product category values
            if selectedCategory == "Vitamins" {
                categoryToMatch = "Vitamins and minerals"
            } else {
                categoryToMatch = selectedCategory
            }
            list = list.filter { $0.category == categoryToMatch }
        }
        if !searchText.isEmpty {
            list = list.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
        return list
    }

    var suggestedProducts: [Product] {
        Array(products.prefix(4))
    }

    var cartCount: Int {
        cartItems.reduce(0) { $0 + $1.quantity }
    }

    var subtotal: Double {
        cartItems.reduce(0) { $0 + $1.totalPrice }
    }

    var totalDiscount: Double {
        cartItems.reduce(0) {
            $0 + (($1.product.price - $1.product.discountedPrice) * Double($1.quantity))
        }
    }

    var deliveryFee: Double { 0 }
    var platformFee: Double { 600 }

    var totalAmount: Double {
        subtotal - totalDiscount + deliveryFee + platformFee
    }

    func addToCart(product: Product, variant: String) {
        if let index = cartItems.firstIndex(where: {
            $0.product.id == product.id && $0.selectedVariant == variant
        }) {
            cartItems[index].quantity += 1
        } else {
            cartItems.append(CartItem(product: product, selectedVariant: variant, quantity: 1))
        }
    }

    func removeFromCart(item: CartItem) {
        cartItems.removeAll { $0.id == item.id }
    }

    func updateQuantity(item: CartItem, delta: Int) {
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            let newQty = cartItems[index].quantity + delta
            if newQty <= 0 {
                cartItems.remove(at: index)
            } else {
                cartItems[index].quantity = newQty
            }
        }
    }

    func toggleWishlist(productId: String) {
        if wishlist.contains(productId) {
            wishlist.remove(productId)
        } else {
            wishlist.insert(productId)
        }
    }

    func placeOrder() {
        orderPlaced = true
        cartItems = []
    }

    func addCard(_ card: SavedCard) {
        savedCards.append(card)
    }
}

struct SavedCard: Identifiable {
    var id: String = UUID().uuidString
    var last4: String
    var brand: String
    var holderName: String = "JAMES ROBINSON"
    var expiry: String = "12/28"
}

