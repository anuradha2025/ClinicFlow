import SwiftUI

struct SignupView: View {
    
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        
        VStack(spacing:20) {
            
            Text("Create Account")
                .font(.title)
            
            TextField("First Name", text:$firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Last Name", text:$lastName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Email", text:$email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField("Password", text:$password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            NavigationLink(destination: OTPView()) {
                Text("Sign Up")
                    .frame(width:200,height:50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

