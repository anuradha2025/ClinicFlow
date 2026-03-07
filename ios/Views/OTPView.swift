import SwiftUI

struct OTPView: View {
    
    @State var otp = ""
    
    var body: some View {
        
        VStack(spacing:20) {
            
            Text("Verify OTP")
                .font(.title)
            
            TextField("Enter OTP", text:$otp)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            NavigationLink(destination: HomeView()) {
                Text("Verify & Continue")
                    .frame(width:200,height:50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

