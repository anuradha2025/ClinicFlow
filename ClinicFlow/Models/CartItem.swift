import Foundation

struct CartItem: Identifiable {
    var id: String = UUID().uuidString
    var product: Product
    var selectedVariant: String
    var quantity: Int

    var totalPrice: Double {
        product.discountedPrice * Double(quantity)
    }
}
