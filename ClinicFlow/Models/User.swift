import Foundation

struct User: Codable, Identifiable {
    var id: String
    var fullName: String
    var email: String
    var phone: String
    var dateOfBirth: String?
    var bloodGroup: String?
    var createdAt: Date
    
    init(id: String = UUID().uuidString,
         fullName: String,
         email: String,
         phone: String,
         dateOfBirth: String? = nil,
         bloodGroup: String? = nil,
         createdAt: Date = Date()) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.phone = phone
        self.dateOfBirth = dateOfBirth
        self.bloodGroup = bloodGroup
        self.createdAt = createdAt
    }
}
