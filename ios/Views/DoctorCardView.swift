import SwiftUI

struct DoctorCardView: View {
    
    var doctor: Doctor
    
    var body: some View {
        
        VStack(alignment:.leading,spacing:10) {
            
            Text(doctor.name)
                .font(.headline)
            
            Text(doctor.specialty)
                .foregroundColor(.gray)
            
            Text(doctor.price)
            
            NavigationLink(destination: AppointmentView()) {
                Text("Book Appointment")
                    .frame(width:160,height:40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

