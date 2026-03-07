import SwiftUI

struct DoctorListView: View {
    
    var doctors = [
        Doctor(name:"Dr. Emily Carter", specialty:"Cardiology", price:"Rs.4500"),
        Doctor(name:"Dr. James Wilson", specialty:"Neurology", price:"Rs.5000")
    ]
    
    var body: some View {
        
        ScrollView {
            
            ForEach(doctors) { doctor in
                
                DoctorCardView(doctor: doctor)
            }
        }
        .navigationTitle("Find a Doctor")
    }
}

