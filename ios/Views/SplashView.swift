import SwiftUI

struct SplashView: View {
    
    var body: some View {
        
        VStack(spacing:20) {
            
            Image(systemName: "heart.text.square.fill")
                .resizable()
                .frame(width:80,height:80)
                .foregroundColor(.blue)
            
            Text("MediQueue Hospital")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Book Hospital Appointments Easily")
                .foregroundColor(.gray)
            
            NavigationLink(destination: LoginView()) {
                Text("Get Started")
                    .frame(width:200,height:50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    SplashView()
}
