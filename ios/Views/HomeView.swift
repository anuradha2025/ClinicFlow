import SwiftUI

struct HomeView: View {
    
    var body: some View {
        
        VStack {
            
            Text("Hello Sarah")
                .font(.title)
                .fontWeight(.bold)
            
            NavigationLink(destination: DoctorListView()) {
                Text("Find Doctor")
                    .frame(width:200,height:50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Spacer()
        }
        .padding()
    }
}


