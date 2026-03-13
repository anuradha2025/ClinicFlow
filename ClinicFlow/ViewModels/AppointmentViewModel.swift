//
//import Foundation
//import Combine
//
//class AppointmentViewModel: ObservableObject {
//    @Published var appointments: [Appointment] = []
//    @Published var doctors: [Doctor] = Doctor.sampleDoctors
//    @Published var isLoading: Bool = false
//    @Published var bookingSuccess: Bool = false
//    @Published var errorMessage: String = ""
//    
//    // Booking state
//    @Published var selectedDoctor: Doctor?
//    @Published var selectedDate: Date = Date()
//    @Published var selectedSlot: String = ""
//    @Published var reason: String = ""
//    
//    private let service = AppointmentService.shared
//    
//    func loadAppointments(for userId: String) {
//        isLoading = true
//        service.fetchAppointments(for: userId) { [weak self] result in
//            self?.isLoading = false
//            if case .success(let list) = result { self?.appointments = list }
//        }
//    }
//    
//    func bookAppointment(userId: String) {
//        guard let doctor = selectedDoctor, !selectedSlot.isEmpty else { return }
//        isLoading = true
//        
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        let dateString = formatter.string(from: selectedDate)
//        
//        let appt = Appointment(
//            userId: userId,
//            doctorId: doctor.id,
//            doctorName: doctor.name,
//            specialization: doctor.specialization,
//            date: dateString,
//            time: selectedSlot,
//            reason: reason.isEmpty ? "General Consultation" : reason
//        )
//        
//        service.bookAppointment(appt) { [weak self] result in
//            self?.isLoading = false
//            switch result {
//            case .success(let a):
//                self?.appointments.append(a)
//                self?.bookingSuccess = true
//                self?.resetBooking()
//            case .failure(let err): self?.errorMessage = err.localizedDescription
//            }
//        }
//    }
//    
//    func cancelAppointment(id: String) {
//        service.cancelAppointment(id: id) { [weak self] _ in
//            if let idx = self?.appointments.firstIndex(where: { $0.id == id }) {
//                self?.appointments[idx].status = .cancelled
//            }
//        }
//    }
//    
//    private func resetBooking() {
//        selectedDoctor = nil
//        selectedSlot = ""
//        reason = ""
//        selectedDate = Date()
//    }
//    
//    var upcomingAppointments: [Appointment] {
//        appointments.filter { $0.status == .confirmed || $0.status == .pending }
//    }
//    
//    var pastAppointments: [Appointment] {
//        appointments.filter { $0.status == .completed || $0.status == .cancelled }
//    }
//}
