//import SwiftUI
//
//struct AppointmentView: View {
//    @EnvironmentObject var authVM: AuthViewModel
//    @StateObject private var apptVM = AppointmentViewModel()
//    @State private var showBooking = false
//    @State private var selectedTab = 0
//    
//    var body: some View {
//        ZStack {
//            AppBackground()
//            
//            VStack(spacing: 0) {
//             
//                HStack {
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text("Hello, \(authVM.currentUser?.fullName.components(separatedBy: " ").first ?? "User") 👋")
//                            .font(.system(size: 13, design: .rounded)).foregroundColor(.white.opacity(0.6))
//                        Text("Your Appointments")
//                            .font(.system(size: 26, weight: .bold, design: .rounded)).foregroundColor(.white)
//                    }
//                    Spacer()
//                    Button(action: { authVM.logout() }) {
//                        Image(systemName: "rectangle.portrait.and.arrow.right")
//                            .font(.system(size: 18)).foregroundColor(.white.opacity(0.7))
//                            .padding(10).background(Circle().fill(Color.white.opacity(0.1)))
//                    }
//                }
//                .padding(.horizontal, 24).padding(.top, 60).padding(.bottom, 20)
//                
//        
//                HStack(spacing: 12) {
//                    StatCard(value: "\(apptVM.upcomingAppointments.count)", label: "Upcoming", icon: "calendar.badge.clock", color: .blue)
//                    StatCard(value: "\(apptVM.pastAppointments.count)", label: "Completed", icon: "checkmark.circle.fill", color: .green)
//                    StatCard(value: "\(Doctor.sampleDoctors.count)", label: "Doctors", icon: "stethoscope", color: .orange)
//                }
//                .padding(.horizontal, 24)
//                
//                HStack(spacing: 0) {
//                    ForEach(["Upcoming", "Past", "Doctors"], id: \.self) { tab in
//                        let idx = ["Upcoming", "Past", "Doctors"].firstIndex(of: tab)!
//                        Button(action: { withAnimation { selectedTab = idx } }) {
//                            Text(tab).font(.system(size: 14, weight: selectedTab == idx ? .semibold : .regular, design: .rounded))
//                                .foregroundColor(selectedTab == idx ? .white : .white.opacity(0.5))
//                                .frame(maxWidth: .infinity).padding(.vertical, 12)
//                                .background(selectedTab == idx ? Color.white.opacity(0.15) : Color.clear)
//                                .cornerRadius(10)
//                        }
//                    }
//                }
//                .padding(4).background(RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.08)))
//                .padding(.horizontal, 24).padding(.top, 20)
//                
//           
//                ScrollView(showsIndicators: false) {
//                    VStack(spacing: 12) {
//                        Spacer().frame(height: 8)
//                        if selectedTab == 0 {
//                            if apptVM.upcomingAppointments.isEmpty {
//                                EmptyStateView(icon: "calendar.badge.plus", title: "No Upcoming Appointments", subtitle: "Book your first appointment below")
//                            } else {
//                                ForEach(apptVM.upcomingAppointments) { appt in
//                                    AppointmentCard(appointment: appt) { apptVM.cancelAppointment(id: appt.id) }
//                                }
//                            }
//                        } else if selectedTab == 1 {
//                            if apptVM.pastAppointments.isEmpty {
//                                EmptyStateView(icon: "clock.arrow.circlepath", title: "No Past Appointments", subtitle: "Your history will appear here")
//                            } else {
//                                ForEach(apptVM.pastAppointments) { AppointmentCard(appointment: $0, onCancel: nil) }
//                            }
//                        } else {
//                            ForEach(apptVM.doctors) { DoctorCard(doctor: $0) { apptVM.selectedDoctor = $0; showBooking = true } }
//                        }
//                        Spacer().frame(height: 160)
//                    }
//                    .padding(.horizontal, 24)
//                }
//                
//                Spacer()
//            }
//            
//         
//            VStack {
//                Spacer()
//                VStack(spacing: 12) {
//       
//                    NavigationLink(destination: PharmacyView()) {
//                        HStack(spacing: 8) {
//                            Image(systemName: "cross.case.fill")
//                                .font(.system(size: 16, weight: .bold))
//                            Text("Pharmacy")
//                                .font(.system(size: 15, weight: .semibold, design: .rounded))
//                        }
//                        .foregroundColor(Theme.buttonText)
//                        .padding(.horizontal, 24)
//                        .frame(height: 50)
//                        .frame(maxWidth: .infinity)
//                        .background(
//                            RoundedRectangle(cornerRadius: 16)
//                                .fill(.white)
//                                .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
//                        )
//                    }
//                    
//         
//                    Button(action: { showBooking = true }) {
//                        HStack(spacing: 8) {
//                            Image(systemName: "plus")
//                                .font(.system(size: 16, weight: .bold))
//                            Text("Book Appointment")
//                                .font(.system(size: 15, weight: .semibold, design: .rounded))
//                        }
//                        .foregroundColor(Theme.buttonText)
//                        .padding(.horizontal, 24)
//                        .frame(height: 50)
//                        .frame(maxWidth: .infinity)
//                        .background(
//                            RoundedRectangle(cornerRadius: 16)
//                                .fill(.white)
//                                .shadow(color: .black.opacity(0.25), radius: 16, x: 0, y: 8)
//                        )
//                    }
//                }
//                .padding(.horizontal, 24)
//                .padding(.bottom, 40)
//            }
//        
//        }
//        .navigationBarHidden(true)
//        .sheet(isPresented: $showBooking) {
//            BookingSheetView(apptVM: apptVM, userId: authVM.currentUser?.id ?? "")
//        }
//        .onAppear { apptVM.loadAppointments(for: authVM.currentUser?.id ?? "") }
//    }
//
//}
//
//
//
//
//struct StatCard: View {
//    let value: String; let label: String; let icon: String; let color: Color
//    var body: some View {
//        VStack(spacing: 6) {
//            Image(systemName: icon).font(.system(size: 18)).foregroundColor(color)
//            Text(value).font(.system(size: 22, weight: .bold, design: .rounded)).foregroundColor(.white)
//            Text(label).font(.system(size: 11, design: .rounded)).foregroundColor(.white.opacity(0.6))
//        }
//        .frame(maxWidth: .infinity).padding(.vertical, 16)
//        .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.08)).overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.12), lineWidth: 1)))
//    }
//}
//
//struct AppointmentCard: View {
//    let appointment: Appointment; let onCancel: (() -> Void)?
//    var statusColor: Color {
//        switch appointment.status {
//        case .confirmed: return .green; case .pending: return .orange
//        case .cancelled: return .red; case .completed: return .blue
//        }
//    }
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            HStack {
//                VStack(alignment: .leading, spacing: 4) {
//                    Text(appointment.doctorName).font(.system(size: 16, weight: .semibold, design: .rounded)).foregroundColor(.white)
//                    Text(appointment.specialization).font(.system(size: 13, design: .rounded)).foregroundColor(.white.opacity(0.6))
//                }
//                Spacer()
//                Text(appointment.status.rawValue).font(.system(size: 11, weight: .semibold, design: .rounded)).foregroundColor(statusColor)
//                    .padding(.horizontal, 10).padding(.vertical, 5).background(Capsule().fill(statusColor.opacity(0.15)))
//            }
//            Divider().background(Color.white.opacity(0.1))
//            HStack(spacing: 20) {
//                Label(appointment.date, systemImage: "calendar").font(.system(size: 13, design: .rounded)).foregroundColor(.white.opacity(0.7))
//                Label(appointment.time, systemImage: "clock").font(.system(size: 13, design: .rounded)).foregroundColor(.white.opacity(0.7))
//            }
//            if !appointment.reason.isEmpty {
//                Text(appointment.reason).font(.system(size: 12, design: .rounded)).foregroundColor(.white.opacity(0.5)).lineLimit(1)
//            }
//            if let onCancel, appointment.status == .confirmed || appointment.status == .pending {
//                Button(action: onCancel) {
//                    Text("Cancel Appointment").font(.system(size: 13, weight: .semibold, design: .rounded)).foregroundColor(.red.opacity(0.8))
//                        .frame(maxWidth: .infinity).padding(.vertical, 10)
//                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.red.opacity(0.08)))
//                }
//            }
//        }
//        .padding(16)
//        .background(RoundedRectangle(cornerRadius: 18).fill(Color.white.opacity(0.08)).overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.12), lineWidth: 1)))
//    }
//}
//
//struct DoctorCard: View {
//    let doctor: Doctor; let onBook: (Doctor) -> Void
//    var body: some View {
//        HStack(spacing: 14) {
//            ZStack {
//                Circle().fill(Color.white.opacity(0.12)).frame(width: 52, height: 52)
//                Image(systemName: doctor.iconName).font(.system(size: 22)).foregroundColor(Theme.accent)
//            }
//            VStack(alignment: .leading, spacing: 4) {
//                Text(doctor.name).font(.system(size: 15, weight: .semibold, design: .rounded)).foregroundColor(.white)
//                Text(doctor.specialization).font(.system(size: 12, design: .rounded)).foregroundColor(.white.opacity(0.6))
//                HStack(spacing: 4) {
//                    Image(systemName: "star.fill").font(.system(size: 11)).foregroundColor(.yellow)
//                    Text("\(doctor.rating, specifier: "%.1f")").font(.system(size: 12, design: .rounded)).foregroundColor(.white.opacity(0.7))
//                }
//            }
//            Spacer()
//            Button(action: { onBook(doctor) }) {
//                Text("Book").font(.system(size: 13, weight: .semibold, design: .rounded)).foregroundColor(Theme.buttonText)
//                    .padding(.horizontal, 16).padding(.vertical, 8)
//                    .background(RoundedRectangle(cornerRadius: 10).fill(.white))
//            }
//        }
//        .padding(16)
//        .background(RoundedRectangle(cornerRadius: 18).fill(Color.white.opacity(0.08)).overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.white.opacity(0.12), lineWidth: 1)))
//    }
//}
//
//struct EmptyStateView: View {
//    let icon: String; let title: String; let subtitle: String
//    var body: some View {
//        VStack(spacing: 16) {
//            Spacer().frame(height: 40)
//            Image(systemName: icon).font(.system(size: 48)).foregroundColor(.white.opacity(0.2))
//            Text(title).font(.system(size: 18, weight: .semibold, design: .rounded)).foregroundColor(.white.opacity(0.5))
//            Text(subtitle).font(.system(size: 14, design: .rounded)).foregroundColor(.white.opacity(0.35))
//        }.frame(maxWidth: .infinity)
//    }
//}
//
//
//struct BookingSheetView: View {
//    @ObservedObject var apptVM: AppointmentViewModel
//    let userId: String
//    @Environment(\.dismiss) var dismiss
//    @State private var step = 0
//    
//    var body: some View {
//        ZStack {
//            AppBackground()
//            VStack(spacing: 0) {
//                Capsule().fill(Color.white.opacity(0.3)).frame(width: 40, height: 4).padding(.top, 12)
//                
//                HStack {
//                    if step > 0 { Button(action: { step -= 1 }) { Image(systemName: "chevron.left").foregroundColor(.white).fontWeight(.semibold) } }
//                    Spacer()
//                    Text(["Choose Doctor","Pick Date & Time","Confirm"][min(step, 2)]).font(.system(size: 18, weight: .bold, design: .rounded)).foregroundColor(.white)
//                    Spacer()
//                    Button(action: { dismiss() }) { Image(systemName: "xmark.circle.fill").font(.system(size: 22)).foregroundColor(.white.opacity(0.5)) }
//                }
//                .padding(.horizontal, 24).padding(.vertical, 16)
//                
//                HStack(spacing: 8) {
//                    ForEach(0..<3) { i in
//                        Capsule().fill(i <= step ? Color.white : Color.white.opacity(0.2)).frame(height: 4).animation(.easeInOut, value: step)
//                    }
//                }
//                .padding(.horizontal, 24).padding(.bottom, 20)
//                
//                if step == 0 {
//                    ScrollView { VStack(spacing: 12) {
//                        ForEach(apptVM.doctors) { doctor in
//                            Button(action: { apptVM.selectedDoctor = doctor; withAnimation { step = 1 } }) {
//                                HStack(spacing: 14) {
//                                    ZStack { Circle().fill(Color.white.opacity(apptVM.selectedDoctor?.id == doctor.id ? 0.25 : 0.12)).frame(width: 52, height: 52); Image(systemName: doctor.iconName).font(.system(size: 22)).foregroundColor(Theme.accent) }
//                                    VStack(alignment: .leading, spacing: 3) {
//                                        Text(doctor.name).font(.system(size: 15, weight: .semibold, design: .rounded)).foregroundColor(.white)
//                                        Text(doctor.specialization).font(.system(size: 12, design: .rounded)).foregroundColor(.white.opacity(0.6))
//                                    }
//                                    Spacer()
//                                    if apptVM.selectedDoctor?.id == doctor.id { Image(systemName: "checkmark.circle.fill").foregroundColor(.green) }
//                                }
//                                .padding(16)
//                                .background(RoundedRectangle(cornerRadius: 18).fill(apptVM.selectedDoctor?.id == doctor.id ? Color.white.opacity(0.18) : Color.white.opacity(0.08)).overlay(RoundedRectangle(cornerRadius: 18).stroke(apptVM.selectedDoctor?.id == doctor.id ? Color.white.opacity(0.4) : Color.white.opacity(0.12), lineWidth: 1.5)))
//                            }
//                        }
//                    }.padding(.horizontal, 24) }
//                    
//                } else if step == 1 {
//                    ScrollView { VStack(alignment: .leading, spacing: 20) {
//                        Text("Select Date").font(.system(size: 14, weight: .semibold, design: .rounded)).foregroundColor(.white.opacity(0.7)).padding(.horizontal, 4)
//                        DatePicker("", selection: $apptVM.selectedDate, in: Date()..., displayedComponents: .date)
//                            .datePickerStyle(.graphical).colorScheme(.dark).padding(12)
//                            .background(RoundedRectangle(cornerRadius: 16).fill(Color.white.opacity(0.08)))
//                        Text("Available Slots").font(.system(size: 14, weight: .semibold, design: .rounded)).foregroundColor(.white.opacity(0.7)).padding(.horizontal, 4)
//                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
//                            ForEach(apptVM.selectedDoctor?.availableSlots ?? [], id: \.self) { slot in
//                                Button(action: { apptVM.selectedSlot = slot }) {
//                                    Text(slot).font(.system(size: 13, weight: .medium, design: .rounded))
//                                        .foregroundColor(apptVM.selectedSlot == slot ? Theme.buttonText : .white)
//                                        .frame(maxWidth: .infinity).padding(.vertical, 10)
//                                        .background(RoundedRectangle(cornerRadius: 10).fill(apptVM.selectedSlot == slot ? .white : Color.white.opacity(0.1)))
//                                }
//                            }
//                        }
//                        Text("Reason (optional)").font(.system(size: 14, weight: .semibold, design: .rounded)).foregroundColor(.white.opacity(0.7)).padding(.horizontal, 4)
//                        TextField("", text: $apptVM.reason, prompt: Text("Describe your symptoms...").foregroundColor(.white.opacity(0.3)))
//                            .font(.system(size: 15, design: .rounded)).foregroundColor(.white)
//                            .padding(14).background(RoundedRectangle(cornerRadius: 14).fill(Color.white.opacity(0.10)).overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.white.opacity(0.2), lineWidth: 1)))
//                        PrimaryButton(label: "Continue", icon: "arrow.right", isEnabled: !apptVM.selectedSlot.isEmpty) { withAnimation { step = 2 } }
//                            .padding(.top, 8)
//                    }.padding(.horizontal, 24) }
//                    
//                } else {
//                    ScrollView { VStack(spacing: 16) {
//                        VStack(spacing: 14) {
//                            if let doc = apptVM.selectedDoctor {
//                                ConfirmRow(icon: "stethoscope", label: "Doctor", value: doc.name)
//                                ConfirmRow(icon: "cross.case.fill", label: "Specialization", value: doc.specialization)
//                            }
//                            ConfirmRow(icon: "calendar", label: "Date", value: apptVM.selectedDate.formatted(date: .long, time: .omitted))
//                            ConfirmRow(icon: "clock.fill", label: "Time", value: apptVM.selectedSlot)
//                            ConfirmRow(icon: "heart.text.square.fill", label: "Hospital", value: "MediQueue Hospital")
//                            if !apptVM.reason.isEmpty { ConfirmRow(icon: "note.text", label: "Reason", value: apptVM.reason) }
//                        }
//                        .padding(20)
//                        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.08)).overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white.opacity(0.12), lineWidth: 1)))
//                        Spacer().frame(height: 8)
//                        PrimaryButton(label: "Confirm Booking", icon: "checkmark.seal.fill", isLoading: apptVM.isLoading) {
//                            apptVM.bookAppointment(userId: userId)
//                        }
//                    }.padding(.horizontal, 24) }
//                }
//                
//                Spacer()
//            }
//        }
//        .onChange(of: apptVM.bookingSuccess) { _, success in if success { apptVM.bookingSuccess = false; dismiss() } }
//    }
//}
//
//struct ConfirmRow: View {
//    let icon: String; let label: String; let value: String
//    var body: some View {
//        HStack(spacing: 14) {
//            Image(systemName: icon).font(.system(size: 16)).foregroundColor(Theme.accent).frame(width: 24)
//            Text(label).font(.system(size: 13, design: .rounded)).foregroundColor(.white.opacity(0.5))
//            Spacer()
//            Text(value).font(.system(size: 13, weight: .semibold, design: .rounded)).foregroundColor(.white).multilineTextAlignment(.trailing)
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        AppointmentView()
//    }
//    .environmentObject(AuthViewModel())
//}

import SwiftUI

struct AppointmentView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        
        ZStack {
            AppBackground()
            
            VStack(spacing: 40) {
                
                Spacer()
                
                Text("Welcome to MediQueue")
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Text("Access our pharmacy services")
                    .font(.system(size: 15, design: .rounded))
                    .foregroundColor(.white.opacity(0.7))
                
                Spacer()
                
                
                // PHARMACY BUTTON
                NavigationLink(destination: PharmacyView()) {
                    HStack(spacing: 8) {
                        Image(systemName: "cross.case.fill")
                            .font(.system(size: 18, weight: .bold))
                        
                        Text("Open Pharmacy")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                    }
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.white)
                    )
                    .padding(.horizontal, 40)
                }
                
                
                Spacer()
                
                
                // LOGOUT
                Button(action: {
                    authVM.logout()
                }) {
                    Text("Logout")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.7))
                }
                
                Spacer().frame(height: 40)
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    NavigationStack {
        AppointmentView()
    }
    .environmentObject(AuthViewModel())
}
