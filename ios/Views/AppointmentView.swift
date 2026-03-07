//import SwiftUI
//
//struct AppointmentView: View {
//
//    var doctor: Doctor
//
//    @State private var selectedDate = Date()
//
//    var body: some View {
//
//        VStack(spacing:20) {
//
//            Text(doctor.name)
//                .font(.title)
//
//            Text(doctor.specialty)
//                .foregroundColor(.gray)
//
//            DatePicker("Select Appointment Date",
//                       selection: $selectedDate,
//                       displayedComponents: .date)
//
//            NavigationLink(destination: PaymentView(doctor: doctor)) {
//
//                Text("Confirm Appointment")
//                    .frame(maxWidth: .infinity)
//                    .frame(height:50)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(10)
//            }
//
//            Spacer()
//
//        }
//        .padding()
//        .navigationTitle("Book Appointment")
//    }
//}

import SwiftUI

struct AppointmentView: View {
    
    var body: some View {
        
        VStack(spacing:20) {
            
            Text("Book Appointment")
                .font(.title)
            
            Text("Choose Date & Time")
            
            NavigationLink(destination: PaymentView()) {
                Text("Confirm Appointment")
                    .frame(width:200,height:50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
