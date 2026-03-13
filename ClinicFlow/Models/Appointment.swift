import Foundation

enum AppointmentStatus: String, Codable {
    case pending = "Pending"
    case confirmed = "Confirmed"
    case cancelled = "Cancelled"
    case completed = "Completed"
}

struct Appointment: Codable, Identifiable {
    var id: String
    var userId: String
    var doctorId: String
    var doctorName: String
    var specialization: String
    var date: String
    var time: String
    var reason: String
    var status: AppointmentStatus
    var createdAt: Date
    
    init(id: String = UUID().uuidString,
         userId: String,
         doctorId: String,
         doctorName: String,
         specialization: String,
         date: String,
         time: String,
         reason: String,
         status: AppointmentStatus = .pending,
         createdAt: Date = Date()) {
        self.id = id
        self.userId = userId
        self.doctorId = doctorId
        self.doctorName = doctorName
        self.specialization = specialization
        self.date = date
        self.time = time
        self.reason = reason
        self.status = status
        self.createdAt = createdAt
    }
}
