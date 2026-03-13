

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
