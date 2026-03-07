import SwiftUI

struct PaymentView: View {
    
    var body: some View {
        
        VStack(spacing:20) {
            
            Text("Payment")
                .font(.largeTitle)
            
            Text("Doctor Charge: Rs.4500")
            
            Button("Pay Now") {
                print("Payment Success")
            }
            .frame(width:200,height:50)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}
