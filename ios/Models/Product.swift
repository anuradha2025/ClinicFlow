import Foundation

struct Product: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var price: Double
    var discountPercent: Int
    var imageName: String 
    var category: String
    var variants: [String]
    var rating: Double
    var soldCount: Int

    var discountedPrice: Double {
        price - (price * Double(discountPercent) / 100)
    }

    static let sampleProducts: [Product] = [
        Product(name: "Vitamin C tablet", description: "Water-soluble vitamins dissolve in water. Leftover amounts of the vitamin leave the body through the urine. Although the body keeps a small reserve of these vitamins, they have to be taken regularly to prevent a shortage in the body.", price: 2000, discountPercent: 5, imageName: "pill.circle.fill", category: "Vitamins and minerals", variants: ["50 mg, 20 pcs", "50 mg, 100 pcs", "10 mg, 20 pcs", "50 mg, 100 pcs"], rating: 4.7, soldCount: 40),
        Product(name: "Zink tablet", description: "Zinc is a nutrient that plays many vital roles in your body. It supports immune function, wound healing, and normal growth.", price: 4000, discountPercent: 8, imageName: "capsule.fill", category: "Vitamins and minerals", variants: ["10 mg, 30 pcs", "25 mg, 60 pcs"], rating: 4.5, soldCount: 60),
        Product(name: "Paracetamol 500mg", description: "Paracetamol is a common painkiller used to treat aches and pain. It can also be used to reduce a high temperature.", price: 350, discountPercent: 0, imageName: "cross.case.fill", category: "Medicines", variants: ["500 mg, 10 pcs", "500 mg, 20 pcs"], rating: 4.9, soldCount: 120),
        Product(name: "Omega-3 Fish Oil", description: "Omega-3 fatty acids are essential fats your body cannot produce on its own. They are vital for brain function and heart health.", price: 3500, discountPercent: 10, imageName: "drop.fill", category: "Vitamins and minerals", variants: ["1000 mg, 30 pcs", "1000 mg, 60 pcs"], rating: 4.6, soldCount: 85),
        Product(name: "Vitamin D3", description: "Vitamin D3 helps your body absorb calcium and phosphorus. It is essential for maintaining healthy bones and teeth.", price: 2500, discountPercent: 5, imageName: "sun.max.fill", category: "Vitamins and minerals", variants: ["1000 IU, 30 pcs", "2000 IU, 60 pcs"], rating: 4.8, soldCount: 95),
        Product(name: "Ibuprofen 400mg", description: "Ibuprofen is a nonsteroidal anti-inflammatory drug used to reduce fever and treat pain or inflammation.", price: 450, discountPercent: 0, imageName: "pills.fill", category: "Medicines", variants: ["400 mg, 10 pcs", "400 mg, 20 pcs"], rating: 4.7, soldCount: 110),
        Product(name: "Hand Sanitizer", description: "Kills 99.9% of germs and bacteria. Moisturizing formula with aloe vera extract.", price: 650, discountPercent: 15, imageName: "hands.sparkles.fill", category: "Beauty and care", variants: ["100 ml", "250 ml", "500 ml"], rating: 4.4, soldCount: 200),
        Product(name: "Protein Powder", description: "High quality whey protein to support muscle growth and recovery after workouts.", price: 8500, discountPercent: 12, imageName: "figure.strengthtraining.traditional", category: "Sport and health", variants: ["500 g Chocolate", "500 g Vanilla", "1 kg Chocolate"], rating: 4.6, soldCount: 75),
    ]

    static let categories = ["Vitamins and minerals", "Beauty and care", "Medicines", "Sport and health"]
}
