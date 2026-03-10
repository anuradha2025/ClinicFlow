
import Foundation

class AppointmentService {
    static let shared = AppointmentService()
    private init() {}
    
    private var appointments: [Appointment] = []
    
    func bookAppointment(_ appointment: Appointment, completion: @escaping (Result<Appointment, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            var confirmed = appointment
            confirmed.status = .confirmed
            self.appointments.append(confirmed)
            self.saveAppointments()
            DispatchQueue.main.async { completion(.success(confirmed)) }
        }
    }
    
    func fetchAppointments(for userId: String, completion: @escaping (Result<[Appointment], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.8) {
            let userAppointments = self.appointments.filter { $0.userId == userId }
            DispatchQueue.main.async { completion(.success(userAppointments)) }
        }
    }
    
    func cancelAppointment(id: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.6) {
            if let index = self.appointments.firstIndex(where: { $0.id == id }) {
                self.appointments[index].status = .cancelled
                self.saveAppointments()
                DispatchQueue.main.async { completion(.success(true)) }
            }
        }
    }
    
    private func saveAppointments() {
        if let data = try? JSONEncoder().encode(appointments) {
            UserDefaults.standard.set(data, forKey: "appointments")
        }
    }
    
    func loadAppointments() {
        guard let data = UserDefaults.standard.data(forKey: "appointments"),
              let saved = try? JSONDecoder().decode([Appointment].self, from: data) else { return }
        appointments = saved
    }
}
