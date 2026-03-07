import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        
        VStack(spacing:20) {
            
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            TextField("Email", text:$email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text:$password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            NavigationLink(destination: HomeView()) {
                Text("Login")
                    .frame(width:200,height:50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            NavigationLink("Create Account", destination: SignupView())
        }
        .padding()
    }
}
